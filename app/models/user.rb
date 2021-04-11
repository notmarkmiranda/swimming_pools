class User < ApplicationRecord
  has_secure_password

  # attr_accessor :password_digest

  validates :email, uniqueness: { case_sensitive: false }

  has_many :pools
  has_many :memberships

  def is_admin?(pool)
    memberships.where(pool: pool, role: 1) || pool.user == self
  end

  def participating_pools
    Pool.left_outer_joins(:memberships).where("memberships.user_id = ? OR pools.user_id = ?", id, id)
  end
end