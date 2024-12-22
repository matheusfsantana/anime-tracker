luffy = User.create!(
  nickname: 'Luffy',
  email: 'luffy@email.com',
  password: 'senha123',
  role: :standard
)

User.create!(
  nickname: 'naruto',
  email: 'naruto@email.com',
  password: 'senha123',
  role: :admin
)

zoro =  User.create!(
  nickname: 'Zoro',
  email: 'zoro@email.com',
  password: 'senha123',
  role: :standard
)

Friendship.create!(
  user: luffy,
  friend: zoro
)

Anime.create!(
  title: 'One Piece',
  sinopse: 'Barely surviving in a barrel after passing through a terrible whirlpool at sea, carefree Monkey D. Luffy ends up aboard a ship under attack by fearsome pirates.',
  status: :currently_airing
)

Anime.create!(
  title: 'Dragon Ball Z',
  sinopse: 'Five years after winning the World Martial Arts tournament, Gokuu is now living a peaceful life with his wife and son.',
  status: :finished_airing,
  quantity_episodes: 391
)

Stat.create!(user: luffy, anime_id: 2, status: :watching)
Stat.create!(user_id: 1, anime_id: 2, status: :completed)
Stat.create!(user_id: 2, anime_id: 1, status: :completed)
Stat.create!(user_id: 2, anime_id: 2, status: :completed)
