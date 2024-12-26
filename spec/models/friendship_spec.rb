require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe '#valid' do
    it 'false when both reference the same user' do
      user = User.create!(nickname: 'Rogério', email: 'rogerio@example.com', password: 'password')

      friend = Friendship.new(user: user, friend: user)

      expect(friend.valid?).to eq false
    end
  end
end
