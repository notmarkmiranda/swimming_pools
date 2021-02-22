require "rails_helper"

describe "User can join existing pool with invite code", type: :feature do
  let(:pool) { create(:pool) }

  before { login_as(pool.user, scope: :user) }

  it "Adds a user when the correct code is used" do
    visit membership_pool_path(pool)

    fill_in "Invite code", with: pool.invite_code
    click_button "Join Pool!"

    expect(current_path).to eq(pool_path(pool))
    expect(page.body.downcase).to have_content(pool.name.downcase)
  end

  it "Does not add a user when the incorrect code is used" do
    visit membership_pool_path(pool)

    fill_in "Invite code", with: pool.invite_code.reverse
    click_button "Join Pool!"

    expect(current_path).to eq(membership_pool_path(pool))
    expect(page).to have_content("Invite code")
  end
end
