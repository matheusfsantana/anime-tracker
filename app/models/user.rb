class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, standard: 0, admin: 1
  validates :nickname, presence: true
  validates :nickname, uniqueness: { case_sensitive: false }

  has_many :stats
  has_one :profile

  after_create :create_profile!
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :friend_requests

  def all_friends
    friends + inverse_friends
  end

  def all_friendships
    Friendship.where(user_id: id).or(Friendship.where(friend_id: id))
  end

  def accepted_friendships
    Friendship.where(user_id: id, status: :accepted).or(Friendship.where(friend_id: id, status: :accepted))
  end

  def pending_friendships
    Friendship.where(friend_id: id, status: :pending)
  end
end
