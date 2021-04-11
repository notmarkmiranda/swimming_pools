require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    before { create(:user) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe "relationships" do
    it { should have_many :pools }
    it { should have_many :memberships }
  end

  describe "methods" do
    describe "#is_admin?"

    describe "#participating_pools" do
      let(:user) { create(:user) }

      subject(:user_participating_pools) { user.participating_pools }

      let!(:owned_pool) { create(:pool, user: user) }
      let!(:admin_pool) { create(:membership, user: user, role: 1).pool }
      let!(:member_pool) { create(:membership, user: user, role: 0).pool }
      let!(:random_pool) { create(:pool) }
      
      it "includes pools that the user owns" do
        expect(user_participating_pools).to include(owned_pool)
      end

      it "includes pools that the user is a secondary admin" do
        expect(user_participating_pools).to include(admin_pool)
      end

      it "includes pools that the user is a member" do
        expect(user_participating_pools).to include(member_pool)
      end

      it "does not include pools that the user is not associated with" do
        expect(user_participating_pools).not_to include(random_pool)
      end
    end
  end
end
