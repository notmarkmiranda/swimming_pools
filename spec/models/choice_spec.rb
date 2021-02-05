require 'rails_helper'

describe Choice, type: :model do
  describe "relationships" do
    it { should belong_to :question }
  end
end
