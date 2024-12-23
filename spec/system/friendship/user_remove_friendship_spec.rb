require 'rails_helper'

describe 'user try to remove friendship and friend request' do
  it 'remove friend with success' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    other_user = User.create!(nickname: 'Roberto', email: 'roberto@example.com', password: 'password', role: :standard)
    third_user = User.create!(nickname: 'Luis', email: 'Luis@example.com', password: 'password', role: :standard)
    Friendship.create!(user: user, friend: other_user, status: :accepted)
    Friendship.create!(user: third_user, friend: user)

    login_as user

    visit root_path
    click_on 'Marcos'
    click_on 'Amigos 1'
    click_on 'remover amizade'

    expect(page).to have_content 'Amizades'
    expect(page).to have_content 'Amizade removida com sucesso'
    expect(page).not_to have_content 'Roberto'
  end

  it 'remove friend with fails' do
    user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
    other_user = User.create!(nickname: 'Roberto', email: 'roberto@example.com', password: 'password', role: :standard)
    third_user = User.create!(nickname: 'Luis', email: 'Luis@example.com', password: 'password', role: :standard)
    Friendship.create!(user: user, friend: other_user, status: :accepted)
    Friendship.create!(user: third_user, friend: user)

    allow_any_instance_of(Friendship).to receive(:delete).and_return(false)

    login_as user

    visit root_path
    click_on 'Marcos'
    click_on 'Amigos 1'
    click_on 'remover amizade'

    expect(page).to have_content 'Roberto'
    expect(page).to have_content 'Não foi possível remover a amizade'
  end
end
