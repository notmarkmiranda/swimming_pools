require "rails_helper"

describe 'User can create pool', type: :feature do
  let(:pool_name) { Faker::Commerce.department }

  describe 'When a user is logged in' do
    let(:user) { create(:user) }

    before { login_as(user, scope: :user) }

    it 'allows a user to create a pool' do
      visit new_pool_path

      fill_in "Name", with: pool_name
      fill_in "Associated game", with: "Superb Owl 55"
      fill_in "Date", with: "2021/02/07"
      choose("pool_multiple_entries_true")

      click_button("Create Pool!")

      expect(page).to have_content(pool_name)
      expect(page).to have_content("Create entries")
    end
  end
end
