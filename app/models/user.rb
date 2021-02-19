class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true

  has_many :pools
  has_many :memberships

  def is_admin?(pool)
    memberships.where(pool: pool, role: 1) || pool.user == self
  end

  def participating_pools
    Pool.left_outer_joins(:memberships).where("memberships.user_id = ? OR pools.user_id = ?", id, id)
  end

  def membered_or_admined_pools
    Pool.joins(:memberships).where("memberships.user_id = ?", id)
  end
end
