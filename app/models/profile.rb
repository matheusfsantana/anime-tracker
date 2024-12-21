class Profile < ApplicationRecord
  belongs_to :user
  enum :privacy, public_access: 0, private_access: 1
end
