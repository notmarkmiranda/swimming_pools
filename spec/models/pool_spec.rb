require 'rails_helper'

describe Pool, type: :model do
  describe "validations" do
    before { create(:pool) }

    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
  end

  describe "relationships" do
    it { should belong_to :user }
  end
end
