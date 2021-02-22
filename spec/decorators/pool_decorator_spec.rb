require 'rails_helper'

describe PoolDecorator, type: :decorator do
  let(:pool) { create(:pool).decorate }

  describe "#status" do
    subject(:pool_status) { pool.status }

    it "Not Started" do
      pool.update(started_at: nil)

      expect(pool_status).to eq("Not Started")
    end

    it "Complete" do
      pool.update(started_at: DateTime.now, completed: true)

      expect(pool_status).to eq("Complete")
    end

    it "In Progress" do
      pool.update(started_at: DateTime.now, completed: false)

      expect(pool_status).to eq("In Progress")
    end
  end
end
