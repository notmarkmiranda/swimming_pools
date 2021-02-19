require 'rails_helper'

describe Pool, type: :model do
  let!(:pool) { create(:pool) }

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
  end

  describe "relationships" do
    it { should belong_to :user }
    it { should have_many :memberships }
    it { should have_many :questions }
    it { should have_many :entries }
  end

  describe "methods" do
    describe "#entries_count" do
      subject(:pool_entries_count) { pool.entries_count }

      it "returns 0 entries" do
        expect(pool_entries_count).to eq(0)
      end

      it "returns 1 entry" do
        create(:entry, pool: pool)

        expect(pool_entries_count).to eq(1)
      end

      it "returns 2 entries" do
        create_list(:entry, 2, pool: pool)

        expect(pool_entries_count).to eq(2)
      end
    end

    describe "#saved_questions" do
      let!(:saved_question) { create(:question, pool: pool) }
      let!(:unsaved_question) { build(:question, pool: pool) }
      let!(:unrelated_question) { create(:question) }

      subject(:pool_saved_questions) { pool.saved_questions }

      it "includes saved questions" do
        expect(pool_saved_questions).to include(saved_question)
        expect(pool_saved_questions).not_to include(unrelated_question)
      end

      it "does not include unsaved questions" do
        expect(pool_saved_questions).not_to include(unsaved_question)
        expect(pool_saved_questions).not_to include(unrelated_question)
      end
    end

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
