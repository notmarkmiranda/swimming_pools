require "rails_helper"

describe 'Admin can remove user from pool', type: :feature  do
  let(:pool) { create(:pool) }
  let!(:other_user) { create(:membership, pool: pool).user }

  before { login_as(pool.user, scope: :user) }

  it "removes a user from the pool" do
    visit pool_path(pool)

    expect(page).to have_content(other_user.email)
    click_button("Remove User")
    expect(page).not_to have_content(other_user.email)
  end
end
