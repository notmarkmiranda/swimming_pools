require 'rails_helper'

describe Pool, type: :model do
  describe "validations" do
    before { create(:pool) }

    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
  end

  describe "relationships" do
    it { should belong_to :user }
    it { should have_many :memberships }
    it { should have_many :questions }
  end

  describe "methods" do
    describe "callbacks" do
      describe "#create_invite_code" do
        let(:pool) { build(:pool) }

        it "adds a unique invite code" do
          expect(pool.invite_code).to be_nil

          pool.save!; pool.reload

          expect(pool.invite_code).not_to be_nil
        end
      end
    end
  end
end
