require 'rails_helper'

describe 'user try to create anime' do
  it 'with success' do
    # login_as :user, scope: :user
    visit root_path

    visit new_anime_path
    fill_in 'Title', with: 'Pokemon'
    fill_in 'Sinopse', with: 'Pokémon are peculiar creatures with a vast array of different abilities and appearances'
    select 'currently_airing', from: 'anime_status'
    click_on 'Salvar'

    expect(current_path).not_to eq new_anime_path
    expect(page).to have_content 'Pokemon'
    expect(page).to have_content 'Pokémon are peculiar creatures with a vast array of different abilities and appearances'
    expect(page).to have_content 'currently_airing'
  end
end
