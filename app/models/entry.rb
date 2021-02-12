class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :pool
  has_many :picks
  accepts_nested_attributes_for :picks

  validate :multiple_entries_allowed, on: [:create]

  def pick=(params)
    self.picks_attributes = params
  end

  def pick_exists?(choice)
    picks.find_by_choice_id(choice.id).present?
  end

  private

  def multiple_entries_allowed
    return if pool.nil? || pool.multiple_entries?
    if previous_entry.present?
      errors.add(:multiple_entries, "User already has an entry in this pool.")
    end
  end

  def previous_entry
    pool.entries.find_by_user_id(user.id)
  end
end

