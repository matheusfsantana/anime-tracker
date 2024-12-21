require 'rails_helper'

describe 'user try to view' do
  context 'your own profile' do
    it 'and should see from homepage' do
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

    it 'and should see when your own profile is private' do
      user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
      user.profile.private_access!
      anime = Anime.create!(
        title: 'Dragon Ball Z',
        sinopse: 'Five years after winning the World Martial Arts tournament, Goku is now living a peaceful life with his wife and son.',
        status: :finished_airing,
        quantity_episodes: 391
      )
      Stat.create!(user: user, anime: anime, status: :completed)

      login_as user
      visit profile_path(user.nickname)

      expect(page).not_to have_content 'Esse perfil é privado.'
      expect(page).to have_content 'Dragon Ball Z'
      expect(page).to have_content 'Concluído'
      expect(page).to have_content 'completed'
    end
  end

  context 'another user profile' do
    it 'and shouldnt see when other user privacy is private' do
      user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
      another_user = User.create(nickname: 'another', email: 'another@example.com', password: 'password', role: :standard)
      another_user.profile.private_access!
      anime = Anime.create!(
        title: 'Dragon Ball Z',
        sinopse: 'Five years after winning the World Martial Arts tournament, Goku is now living a peaceful life with his wife and son.',
        status: :finished_airing,
        quantity_episodes: 391
      )
      Stat.create!(user: another_user, anime: anime, status: :completed)

      login_as user
      visit profile_path(another_user.nickname)

      expect(page).to have_content 'Esse perfil é privado.'
      expect(page).not_to have_content 'Dragon Ball Z'
      expect(page).not_to have_content 'Concluído'
      expect(page).not_to have_content 'completed'
    end

    it 'and should see when other user privacy is public' do
      user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)
      another_user = User.create(nickname: 'another', email: 'another@example.com', password: 'password', role: :standard)
      another_user.profile.public_access!
      anime = Anime.create!(
        title: 'Dragon Ball Z',
        sinopse: 'Five years after winning the World Martial Arts tournament, Goku is now living a peaceful life with his wife and son.',
        status: :finished_airing,
        quantity_episodes: 391
      )
      Stat.create!(user: another_user, anime: anime, status: :completed)

      login_as user
      visit profile_path(another_user.nickname)

      expect(page).to have_content 'another'
      expect(page).to have_content 'Dragon Ball Z'
      expect(page).to have_content 'Concluído'
      expect(page).to have_content 'completed'
    end

    it 'and should redirect to your own profile when user doesnt exists' do
      user = User.create!(nickname: 'Marcos', email: 'marcos@example.com', password: 'password', role: :standard)

      login_as user
      visit profile_path('user_nao_existente')

      expect(current_path).to eq profile_path(user.nickname)
      expect(page).to have_content 'O perfil que tentou acessar não existe!'
    end
  end
end
