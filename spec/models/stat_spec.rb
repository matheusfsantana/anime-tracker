require 'rails_helper'

RSpec.describe Stat, type: :model do
  describe '#valid' do
    it 'should be invalid without a user' do
      stat = Stat.new()

      expect(stat).not_to be_valid
      expect(stat.errors).to include(:user)
    end

    it 'should be invalid without a anime' do
      stat = Stat.new()

      expect(stat).not_to be_valid
      expect(stat.errors).to include(:anime)
    end

    it 'should be valid with a user and an anime' do
      user = User.create!(nickname: 'Rogério', email: 'user@example.com', password: 'password')
      anime = Anime.create!(
        title: 'One Piece',
        sinopse: 'Uma sinopse qualquer',
        status: :currently_airing,
        quantity_episodes: 100
      )

      stats = Stat.new(user: user, anime: anime)
      stats.valid?
      expect(stats).to be_valid
    end
  end

  describe '#set_default_current_ep' do
    it 'should set current_ep to 0 by default' do
      stat = Stat.new()
      stat.valid?
      expect(stat.current_ep).to eq 0
    end
  end

  describe '#set_default_status' do
    it 'should set status to watching by default' do
      stat = Stat.new()
      stat.valid?
      expect(stat.status).to eq 'watching'
    end

    it 'respects provided status value' do
      user = User.create!(nickname: 'Test', email: 'test@example.com', password: 'password')
      anime = Anime.create!(title: 'Anime', sinopse: 'Uma descrição qualquer', status: :currently_airing, quantity_episodes: 10)

      stat = Stat.create!(user: user, anime: anime, status: :completed)
      expect(stat.status).to eq('completed')
    end
  end
end
