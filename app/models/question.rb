class Question < ApplicationRecord
  belongs_to :pool
  has_many :choices

  accepts_nested_attributes_for :choices, reject_if: :reject_blank_choices

  validates :text, presence: true, uniqueness: { scope: :pool_id }

  def reject_blank_choices(attributes)
    attributes["text"].blank?
  end
end
