require 'rails_helper'

describe Membership, type: :model do
  describe "validations" do
    let(:enum_values) { { member: 0, admin: 1 } }

    before { create(:membership) }

    it { should validate_uniqueness_of(:user).scoped_to(:pool_id) }
    it { should define_enum_for(:role).with_values(enum_values) }
  end

  describe "relationships" do
    it { should belong_to :user }
    it { should belong_to :pool }
  end
end
