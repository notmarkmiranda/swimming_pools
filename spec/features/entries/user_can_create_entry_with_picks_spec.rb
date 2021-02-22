require "rails_helper"

describe "User can create entry_with_picks", type: :feature do
  let(:pool) { create(:pool_with_questions_and_choices) }
  let(:non_admin_user) { create(:membership, pool: pool, role: 0).user }
  let(:entry) { create(:entry, pool: pool) }
  let(:first_question) { pool.questions[0] }
  let(:first_choice) { first_question.choices.first }
  let(:other_first_choice) { first_question.choices.last }
  let(:second_question) { pool.questions[-1] }
  let(:second_choice) { second_question.choices.last }
  let(:other_second_choice) { second_question.choices.first }

  before { login_as(non_admin_user, scope: :user) }

  describe "A user can create an entry" do
    it "creates an entry" do
      visit pool_path(pool)

      click_button "Create New Entry!"

      expect(page).to have_content("Add picks")
    end
  end

  describe "A user who has an entry for a pool that does not allow multiple entries, cannot create another one" do
    before { create(:entry, pool: pool, user: non_admin_user) }

    it "does not create an entry and redirects to the pool path" do
      visit pool_path(pool)

      click_button "Create New Entry!"

      expect(current_path).to eq(pool_path(pool))
      expect(page.body.downcase).to have_content(pool.name.downcase)
      expect(page).not_to have_content("Add picks")
    end
  end

  describe "A user can create picks inside an entry" do
    it "creates a pick inside an entry" do
      visit pool_entry_path(pool, entry)

      choose("entry_pick_#{first_question.id}_choice_id_#{first_choice.id}")
      choose("entry_pick_#{second_question.id}_choice_id_#{second_choice.id}")

      click_button "Save Entry!"

      expect(current_path).to eq(pool_entry_path(pool, entry))
      expect(page).to have_content("Status: Complete")
      expect(find_field("entry_pick_#{first_question.id}_choice_id_#{first_choice.id}")).to be_checked
      expect(find_field("entry_pick_#{first_question.id}_choice_id_#{other_first_choice.id}")).not_to be_checked
      expect(find_field("entry_pick_#{second_question.id}_choice_id_#{second_choice.id}")).to be_checked
      expect(find_field("entry_pick_#{second_question.id}_choice_id_#{other_second_choice.id}")).not_to be_checked
    end
  end

  describe "A user can save an entry without all of the picks" do
    it "creates a pick" do
      visit pool_entry_path(pool, entry)

      choose("entry_pick_#{first_question.id}_choice_id_#{first_choice.id}")
      click_button "Save Entry!"

      expect(current_path).to eq(pool_entry_path(pool, entry))
      expect(find_field("entry_pick_#{first_question.id}_choice_id_#{first_choice.id}")).to be_checked
      expect(find_field("entry_pick_#{first_question.id}_choice_id_#{other_first_choice.id}")).not_to be_checked
      expect(find_field("entry_pick_#{second_question.id}_choice_id_#{second_choice.id}")).not_to be_checked
      expect(find_field("entry_pick_#{second_question.id}_choice_id_#{other_second_choice.id}")).not_to be_checked
    end
  end

  describe "An entry without all of the picks shows as incomplete" do
    it "displays incomplete" do
      visit pool_entry_path(pool, entry)

      choose("entry_pick_#{first_question.id}_choice_id_#{first_choice.id}")
      click_button "Save Entry!"

      expect(current_path).to eq(pool_entry_path(pool, entry))
      expect(page).to have_content("Status: Incomplete")
    end
  end

  pending "An admin cannot add a question if an entry already exists"
  # maybe think this through more?
  # depending on the amount of time left before the start,
  # adding a question could fire off a warning email to users to let them know?
  # <%# ff.collection_radio_buttons("question#{question.id}", question.choices, :id, :text) %>
end
