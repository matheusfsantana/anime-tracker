require 'rails_helper'

describe 'user try to edit anime' do
  it 'must be an admin' do
    anime = Anime.create!(
      title: 'Dragon Ball Z',
      sinopse: 'Five years after winning the World Martial Arts tournament, Gokuu is now living a peaceful life with his wife and son.',
      status: :finished_airing,
      quantity_episodes: 391
    )
    admin = User.create!(nickname: 'Rogério', email: 'user@example.com', password: 'password', role: :standard)
    login_as admin
    visit edit_anime_path anime

    expect(current_path).to eq root_path
  end

  it 'with success' do
    anime = Anime.create!(
      title: 'Dragon Ball Z',
      sinopse: 'Five years after winning the World Martial Arts tournament, Gokuu is now living a peaceful life with his wife and son.',
      status: :finished_airing,
      quantity_episodes: 391
    )
    admin = User.create!(nickname: 'Rogério', email: 'user@example.com', password: 'password', role: :admin)

    login_as admin
    visit root_path

    visit edit_anime_path anime
    fill_in 'Titulo', with: 'Pokemon'
    fill_in 'Sinopse', with: 'Pokémon are peculiar creatures with a vast array of different abilities and appearances'
    select 'Lançando', from: 'anime_status'
    click_on 'Salvar'

    expect(page).to have_content 'Pokemon'
    expect(page).to have_content 'Pokémon are peculiar creatures with a vast array of different abilities and appearances'
    expect(page).to have_content 'Lançando'
  end

  it 'And leave required fields blank' do
    anime = Anime.create!(
      title: 'Dragon Ball Z',
      sinopse: 'Five years after winning the World Martial Arts tournament, Gokuu is now living a peaceful life with his wife and son.',
      status: :finished_airing,
      quantity_episodes: 391
    )
    admin = User.create!(nickname: 'Rogério', email: 'user@example.com', password: 'password', role: :admin)

    login_as admin
    visit root_path

    visit edit_anime_path anime
    fill_in 'Titulo', with: ''
    fill_in 'Sinopse', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Erro ao tentar alterar o anime'
  end
end
