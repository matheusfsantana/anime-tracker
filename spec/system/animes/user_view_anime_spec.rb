require 'rails_helper'

describe 'user try to view anime' do
  it 'with success' do
    user = User.create!(nickname: 'Rogério', email: 'user@example.com', password: 'password')

    Anime.create!(
      title: 'One Piece',
      sinopse: 'Barely surviving in a barrel after passing through a terrible whirlpool at sea, carefree Monkey D. Luffy ends up aboard a ship under attack by fearsome pirates.',
      status: :currently_airing
    )

    Anime.create!(
      title: 'Dragon Ball Z',
      sinopse: 'Five years after winning the World Martial Arts tournament, Gokuu is now living a peaceful life with his wife and son.',
      status: :finished_airing,
      quantity_episodes: 391
    )

    login_as user
    visit root_path

    visit animes_path
    click_on 'One Piece'

    expect(page).to have_content 'One Piece'
    expect(page).to have_content 'Sinopse'
    expect(page).to have_content 'Barely surviving in a barrel after passing through a terrible whirlpool at sea, carefree Monkey D. Luffy ends up aboard a ship under attack by fearsome pirates.'
  end
end
