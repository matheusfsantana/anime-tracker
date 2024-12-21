require 'rails_helper'

describe 'User change his profile' do
  it 'and shouldnt see the edit button when its another user profile' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    another_user = User.create(nickname: 'another', email: 'another@example.com', password: 'password', role: :standard)

    login_as user
    visit profile_path(another_user.nickname)

    expect(page).not_to have_link 'Editar perfil'
  end

  it 'and should see the edit button when its your profile' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)

    login_as user
    visit profile_path(user.nickname)

    expect(page).to have_link 'Editar perfil'
  end

  it 'to private' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)

    login_as user
    visit root_path
    click_on 'Editar perfil'
    select 'Acesso Privado', from: 'Privacidade'
    click_on 'Salvar'
    user.reload

    expect(current_path).to eq profile_path(user.nickname)
    expect(page).to have_content 'Perfil foi atualizado com sucesso!'
    expect(user.profile.private_access?).to be true
  end

  it 'to public' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    user.profile.private_access!

    login_as user
    visit root_path
    click_on 'Editar perfil'
    select 'Acesso Público', from: 'Privacidade'
    click_on 'Salvar'
    user.reload

    expect(current_path).to eq profile_path(user.nickname)
    expect(page).to have_content 'Perfil foi atualizado com sucesso!'
    expect(user.profile.public_access?).to be true
  end

  it 'and add about him' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    user.profile.private_access!

    login_as user
    visit root_path
    click_on 'Editar perfil'
    fill_in 'Sobre mim', with: 'Teste'
    click_on 'Salvar'
    user.reload

    expect(current_path).to eq profile_path(user.nickname)
    expect(page).to have_content 'Perfil foi atualizado com sucesso!'
    expect(user.profile.about).to eq 'Teste'
  end
end
