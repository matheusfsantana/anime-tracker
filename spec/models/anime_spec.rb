require 'rails_helper'

RSpec.describe Anime, type: :model do
  describe '#valid' do
    context 'presence' do
      it 'false when title is not present' do
        anime = Anime.new()

        expect(anime).not_to be_valid
        expect(anime.errors).to include(:title)
        expect(anime.errors).not_to include(:sinopse)
        expect(anime.errors).not_to include(:status)
        expect(anime.errors).not_to include(:quantity_episodes)
      end
    end
  end
end
