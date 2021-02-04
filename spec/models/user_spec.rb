require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe "relationships" do
    it { should have_many :pools }
  end
end
