require "rails_helper"

describe "User can edit pool spec", type: :feature do
  let!(:pool) { create(:pool) }

  describe "As the owner of the pool" do
    let(:user) { pool.user }
    let(:original_name) { pool.name }
    let(:new_name) { pool.name.reverse }

    before { login_as(user, scope: :user) }

    it "updates the pool" do
      visit edit_pool_path(pool)

      fill_in "Name", with: new_name
      click_button "Update Pool!"

      expect(page).to have_content(new_name)
      expect(page).not_to have_content(original_name)
    end
  end

  describe "As the non-owner of the pool"
end
