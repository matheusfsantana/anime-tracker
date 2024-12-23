require 'rails_helper'

describe 'user try to accept a friend request' do
  it 'should be authenticated' do
    visit friendships_path(pending: true)

    expect(current_path).to eq new_user_session_path
  end

  it 'with success' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    other_user = User.create!(nickname: 'Roberto', email: 'roberto@example.com', password: 'password', role: :standard)
    third_user = User.create!(nickname: 'Luis', email: 'Luis@example.com', password: 'password', role: :standard)
    Friendship.create!(user: user, friend: other_user, status: :accepted)
    Friendship.create!(user: third_user, friend: user)

    login_as user

    visit root_path

    click_on 'Marcos'
    click_on 'Amigos 1'
    click_on 'Solicitações de amizade'
    click_on 'Aceitar'

    expect(page).to have_content 'Amizades'
    expect(page).to have_content 'Roberto'
    expect(page).to have_content 'Luis'
  end

  it 'with fail due to some error' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    other_user = User.create!(nickname: 'Roberto', email: 'roberto@example.com', password: 'password', role: :standard)
    third_user = User.create!(nickname: 'Luis', email: 'Luis@example.com', password: 'password', role: :standard)
    Friendship.create!(user: user, friend: other_user, status: :accepted)
    Friendship.create!(user: third_user, friend: user)

    allow_any_instance_of(Friendship).to receive(:update).and_return(false)

    login_as user

    visit root_path

    click_on 'Marcos'
    click_on 'Amigos 1'
    click_on 'Solicitações de amizade'
    click_on 'Aceitar'

    expect(page).to have_content 'Erro ao tentar aceitar pedido de amizade'
  end
end
