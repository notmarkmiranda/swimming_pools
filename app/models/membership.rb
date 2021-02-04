class Membership < ApplicationRecord
  validates :user, uniqueness: { scope: :pool_id }
  belongs_to :user
  belongs_to :pool

  enum role: { member: 0, admin: 1 }
end
