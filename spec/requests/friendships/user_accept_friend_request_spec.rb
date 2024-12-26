require 'rails_helper'

describe 'User try to accept friend request' do
  it 'with success' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    other_user = User.create!(nickname: 'Roberto', email: 'roberto@example.com', password: 'password', role: :standard)
    friendship = Friendship.create!(user: other_user, friend: user)

    login_as user

    patch accept_friendship_path(friendship)

    expect(response).to have_http_status :found
  end

  it 'fail because because he was not authenticated' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    other_user = User.create!(nickname: 'Roberto', email: 'roberto@example.com', password: 'password', role: :standard)
    friendship = Friendship.create!(user: user, friend: other_user, status: :accepted)

    patch accept_friendship_path(friendship)

    expect(response).to redirect_to new_user_session_path
  end

  it 'fail because its not associated with the user' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    other_user = User.create!(nickname: 'Roberto', email: 'roberto@example.com', password: 'password', role: :standard)
    third_user = User.create!(nickname: 'Luis', email: 'Luis@example.com', password: 'password', role: :standard)
    friendship = Friendship.create!(user: third_user, friend: other_user)

    login_as user

    patch accept_friendship_path(friendship)

    expect(response).to have_http_status :not_found
  end
end
