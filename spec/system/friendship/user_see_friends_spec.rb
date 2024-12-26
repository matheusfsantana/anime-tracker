require 'rails_helper'

describe 'user try to view friends' do
  it 'should be authenticated' do
    visit friendships_path

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

    expect(page).to have_content 'Amizades'
    expect(page).to have_content 'Roberto'
    expect(page).not_to have_content 'Luis'
  end

  it 'and cant see other user friends' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    other_user = User.create!(nickname: 'Roberto', email: 'roberto@example.com', password: 'password', role: :standard)
    Friendship.create!(user: user, friend: other_user)

    login_as user

    visit profile_path(nickname: other_user.nickname)

    expect(page).not_to have_link 'Amigos 1'
  end
end
