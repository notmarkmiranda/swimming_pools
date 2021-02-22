require 'rails_helper'

describe "Admin cannot add questions to a pool that has started_spec", type: :feature do
  let(:pool) { create(:pool, started_at: DateTime.now) }
  let(:user) { pool.user }

  before { login_as(user, scope: :user) }

  it "does not allow an admin to add questions" do
    visit pool_path(pool)

    expect(page.body.downcase).to have_content(pool.name.downcase)
    expect(page).not_to have_content("Create questions")
    expect(page).not_to have_content("Question text")
  end
end
