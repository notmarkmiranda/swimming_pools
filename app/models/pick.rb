class Pick < ApplicationRecord
  belongs_to :entry
  belongs_to :choice

  validates :entry, uniqueness: { scope: :choice_id }
end
