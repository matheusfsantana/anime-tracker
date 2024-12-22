class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validate :user_and_friend_must_be_different

  private

  def user_and_friend_must_be_different
    if user.id == friend.id
      errors.add(:friend, "can't be the same as user")
    end
  end
end
