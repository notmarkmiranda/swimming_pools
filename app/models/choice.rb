class Choice < ApplicationRecord
  belongs_to :question
  has_many :picks

  accepts_nested_attributes_for :picks
end
