require 'rails_helper'

describe 'User see dashboard on intern pages' do
  it 'when signed in' do
    user = User.create!(
      nickname: 'Luffy',
      email: 'luffy@email.com',
      password: 'senha123',
      role: :standard
    )

    login_as user

    visit root_path

    within 'aside' do
      expect(page).to have_content('Menu')
      expect(page).to have_link('Animes', href: animes_path)
      expect(page).to have_link('Perfil', href: profile_path(user.nickname))
    end
  end
end
