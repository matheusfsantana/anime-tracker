describe 'User' do
  context 'register anime' do
    it 'and is not authenticated' do
      post animes_path,
        params: { anime: { title: 'Hunter x Hunter',
                           sinopse: 'Hunters devote themselves to accomplishing hazardous tasks' }
                         }

      expect(response).to redirect_to new_user_session_path
      expect(Anime.all).to eq []
    end

    it 'and must be an admin' do
      user = User.create!(nickname: 'Rogério', email: 'user@example.com', password: 'password')

      login_as user

      post animes_path,
        params: { anime: { title: 'Hunter x Hunter',
                           sinopse: 'Hunters devote themselves to accomplishing hazardous tasks' }
                         }

      expect(response).to redirect_to root_path
      expect(Anime.all).to eq []
    end
  end

  context 'edit anime' do
    it 'and is not authenticated' do
      anime = Anime.create!(
        title: 'Dragon Ball B',
        sinopse: 'Five years after winning the World Martial Arts tournament, Gokuu is now living a peaceful life with his wife and son.',
        status: :finished_airing,
        quantity_episodes: 391
      )

      patch anime_path(anime),
        params: { anime: { title: 'Dragon Ball Z' } }

      expect(response).to redirect_to new_user_session_path
      expect(Anime.first.title).to eq 'Dragon Ball B'
    end

    it 'and must be an admin' do
      user = User.create!(nickname: 'Rogério', email: 'user@example.com', password: 'password')
      anime = Anime.create!(
        title: 'Dragon Ball B',
        sinopse: 'Five years after winning the World Martial Arts tournament, Gokuu is now living a peaceful life with his wife and son.',
        status: :finished_airing,
        quantity_episodes: 391
      )

      login_as user

      patch anime_path(anime),
        params: { anime: { title: 'Dragon Ball Z' } }

      expect(response).to redirect_to root_path
      expect(Anime.first.title).to eq 'Dragon Ball B'
    end
  end
end
