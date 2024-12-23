require 'rails_helper'

describe 'user try to send friend request' do
  it 'with success' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    other_user = User.create!(nickname: 'Roberto', email: 'roberto@example.com', password: 'password', role: :standard)

    login_as user

    visit root_path
    visit profile_path(nickname: other_user.nickname)

    click_on 'Mandar pedido de amizade'

    expect(page).to have_content 'Pedido de amizade enviado'
  end
end
