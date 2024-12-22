require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe '#valid' do
    it 'false when user try to send a friend request to himself' do
      user = User.create!(nickname: 'Cris', email: 'cris@example.com', password: 'password')

      request = FriendRequest.new(user: user, target_user: user)

      expect(request.valid?).to eq false
    end
  end
end
