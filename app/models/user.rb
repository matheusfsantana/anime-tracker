class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, standard: 0, admin: 1
  validates :nickname, presence: true
  validates :nickname, uniqueness: { case_sensitive: false }

  has_many :stats
end
