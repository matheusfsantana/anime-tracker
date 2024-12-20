require 'rails_helper'

describe 'user try to create anime' do
  it 'must be an admin' do
    admin = User.create!(nickname: 'Rogério', email: 'user@example.com', password: 'password', role: :normal)
    login_as admin
    visit new_anime_path

    expect(current_path).to eq root_path
  end

  it 'with success' do
    admin = User.create!(nickname: 'Rogério', email: 'user@example.com', password: 'password', role: :admin)

    login_as admin
    visit root_path

    visit new_anime_path
    fill_in 'Titulo', with: 'Pokemon'
    fill_in 'Sinopse', with: 'Pokémon are peculiar creatures with a vast array of different abilities and appearances'
    select 'Lançando', from: 'anime_status'
    click_on 'Salvar'

    expect(current_path).not_to eq new_anime_path
    expect(page).to have_content 'Pokemon'
    expect(page).to have_content 'Pokémon are peculiar creatures with a vast array of different abilities and appearances'
    expect(page).to have_content 'Lançando'
  end
end
