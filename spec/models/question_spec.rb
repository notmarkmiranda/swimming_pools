require 'rails_helper'

describe Question, type: :model do
  describe "relationships" do
    it { should belong_to :pool }
  end

  describe "validations"

  describe "methods"
end
