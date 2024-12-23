require 'rails_helper'

describe 'user try to send a friend request' do
  it 'to himself' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)

    login_as user

    post user_friendships_path(user_id: user.id)

    follow_redirect!

    expect(response.body).to include('Erro ao tentar enviar um pedido de amizade')
  end
end
