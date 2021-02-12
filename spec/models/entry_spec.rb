require 'rails_helper'

describe Entry, type: :model do
  describe "relationships" do
    before { create(:entry) }
    it { should belong_to :user }
    it { should belong_to :pool }
    it { should have_many :picks }
  end

  describe "validations" do
    let(:pool) { create(:pool) }
    let(:user) { pool.user }
    let(:second_entry) { build(:entry, pool: pool, user: user) }

    before { create(:entry, pool: pool, user: user) }

    it "allows multiple entries when true" do
      pool.update(multiple_entries: true)

      expect { second_entry.save }.to change(Entry, :count).by(1)
    end

    it "prevents multiple entries when false" do
      pool.update(multiple_entries: false)

      expect { second_entry.save }.not_to change(Entry, :count)
    end
  end

  describe "methods"
end
