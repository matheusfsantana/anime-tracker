require 'rails_helper'

describe 'user try to view' do
  it 'his own profile from homepage' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    anime = Anime.create!(
      title: 'Dragon Ball Z',
      sinopse: 'Five years after winning the World Martial Arts tournament, Goku is now living a peaceful life with his wife and son.',
      status: :finished_airing,
      quantity_episodes: 391
    )
    Stat.create!(user: user, anime: anime, status: :completed)

    login_as user

    visit root_path

    expect(page).to have_content 'Marcos'
    expect(page).to have_content 'Dragon Ball Z'
    expect(page).to have_content 'Concluído'
    expect(page).to have_content 'completed'
  end

  it 'other user profile' do
    user = User.create!(nickname: 'Antonio', email: 'antonio@example.com', password: 'password', role: :standard)
    anime = Anime.create!(
      title: 'One Piece',
      sinopse: 'Barely surviving in a barrel after passing through a terrible whirlpool at sea, carefree Monkey D. Luffy ends up aboard a ship under attack by fearsome pirates.',
      status: :currently_airing
    )
    Stat.create!(user: user, anime: anime, status: :completed)

    other_user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    other_anime = Anime.create!(
      title: 'Dragon Ball Z',
      sinopse: 'Five years after winning the World Martial Arts tournament, Goku is now living a peaceful life with his wife and son.',
      status: :finished_airing,
      quantity_episodes: 391
    )
    Stat.create!(user: other_user, anime: other_anime, status: :completed)

    login_as user

    visit profile_path other_user.nickname

    within 'main' do
      expect(page).not_to have_content 'Antonio'
      expect(page).not_to have_content 'One Piece'
      expect(page).to have_content 'Marcos'
      expect(page).to have_content 'Dragon Ball Z'
    end
  end
end
