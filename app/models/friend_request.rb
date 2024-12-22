class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :target_user, class_name: "User"

  validate :user_and_target_user_must_be_different

  private

  def user_and_target_user_must_be_different
    if user.id == target_user.id
      errors.add(:target_user, "can't be the same as user")
    end
  end
end
