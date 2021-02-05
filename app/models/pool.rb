class Pool < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id }
  belongs_to :user
  has_many :memberships
  has_many :questions

  after_create_commit :add_invite_code

  private

  def add_invite_code
    code = generate_string
    return add_invite_code if Pool.pluck(:invite_code).include?(code)
    self.invite_code = code
    save!
  end

  def generate_string
    Array.new(6) { [*"A".."Z"].sample }.join
  end
end
