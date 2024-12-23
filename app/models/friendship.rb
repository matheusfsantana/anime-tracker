class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validate :user_and_friend_must_be_different

  enum :status, pending: 0, accepted: 2

  def get_friend(user)
    if self.user == user
      friend
    elsif friend == user
      self.user
    else
      nil
    end
  end

  private

  def user_and_friend_must_be_different
    if user.id == friend.id
      errors.add(:friend, "can't be the same as user")
    end
  end
end
