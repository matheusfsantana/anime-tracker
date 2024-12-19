class Anime < ApplicationRecord
  enum :status, currently_airing: 0, not_yet_airing: 2, finished_airing: 4, cancelled: 6
  has_one_attached :poster

  validates :title, presence: true
end
