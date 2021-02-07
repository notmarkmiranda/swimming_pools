require 'rails_helper'

describe Pick, type: :model do
  describe "relationships" do
    it { should belong_to :entry }
    it { should belong_to :choice }
  end

  describe "validations" do
    before { create(:pick) }
    it { should validate_uniqueness_of(:entry).scoped_to(:choice_id)}
  end
end
