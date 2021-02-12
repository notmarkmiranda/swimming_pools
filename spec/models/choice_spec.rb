require 'rails_helper'

describe Choice, type: :model do
  describe "relationships" do
    it { should belong_to :question }
    it { should have_many :picks }
  end
end
