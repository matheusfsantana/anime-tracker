class Stat < ApplicationRecord
  belongs_to :user
  belongs_to :anime
  enum :status, watching: 0, completed: 1, on_hold: 2, dropped: 3, plan_to_watch: 4

  validates :user, presence: true
  validates :anime, presence: true

  before_validation :set_default_current_ep, on: :create
  before_validation :set_default_status, on: :create

  private
  def set_default_current_ep
    self.current_ep ||= 0
  end

  def set_default_status
    self.status = :watching if status.nil?
  end
end
