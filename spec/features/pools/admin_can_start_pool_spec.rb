require "rails_helper"

describe "Admin can start a pool", type: :feature do
  let(:pool) { create(:pool, started_at: nil) }
  let(:user) { pool.user }

  before { login_as(user, scope: :user) }

  it "redirects back to pool and has started_at time" do
    visit pool_path(pool)

    click_button("Start pool")

    expect(current_path).to eq(pool_path(pool))
    expect(page).to have_button("Start pool", disabled: true)
  end
end
