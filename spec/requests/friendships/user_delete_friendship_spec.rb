require 'rails_helper'

describe 'user try to delete friendship' do
  it 'fail because its not associated with the user' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    other_user = User.create!(nickname: 'Roberto', email: 'roberto@example.com', password: 'password', role: :standard)
    third_user = User.create!(nickname: 'Luis', email: 'Luis@example.com', password: 'password', role: :standard)
    friendship = Friendship.create!(user: third_user, friend: other_user)

    login_as user

    delete friendship_path(friendship)

    expect(response).to have_http_status :not_found
  end
end
