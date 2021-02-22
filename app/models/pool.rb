class Pool < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user
  has_many :memberships
  has_many :questions
  has_many :entries

  after_create_commit :add_invite_code

  def entries_count
    entries.count
  end

  def saved_questions
    questions.where.not(id: nil)
  end

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
