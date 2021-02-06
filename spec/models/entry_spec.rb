require 'rails_helper'

describe Entry, type: :model do
  describe "relationships" do
    it { should belong_to :user }
    it { should belong_to :pool }
  end

  describe "validations"

  describe "methods"
end
