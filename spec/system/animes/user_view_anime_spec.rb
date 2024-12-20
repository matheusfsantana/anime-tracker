require 'rails_helper'

describe 'user try to view anime' do
  it 'with success' do
    anime = Anime.create!(
      title: 'One Piece',
      sinopse: 'Barely surviving in a barrel after passing through a terrible whirlpool at sea, carefree Monkey D. Luffy ends up aboard a ship under attack by fearsome pirates.',
      status: :currently_airing
    )
    # login_as :user, scope: :user
    visit root_path

    visit anime_path anime

    expect(page).to have_content 'One Piece'
    expect(page).to have_content 'Sinopse'
    expect(page).to have_content 'Barely surviving in a barrel after passing through a terrible whirlpool at sea, carefree Monkey D. Luffy ends up aboard a ship under attack by fearsome pirates.'
  end
end
