require 'rails_helper'

describe Question, type: :model do
  describe "relationships" do
    it { should belong_to :pool }
    it { should have_many :choices }
    it { should accept_nested_attributes_for :choices }
  end
  
  describe "validations" do
    before { create(:question) }

    it { should validate_presence_of :text }
    it { should validate_uniqueness_of(:text).scoped_to(:pool_id) }
  end

  describe "methods"
end
