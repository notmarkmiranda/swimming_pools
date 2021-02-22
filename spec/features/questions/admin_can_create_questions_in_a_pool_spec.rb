require "rails_helper"

describe "Admin can create questions in a pool", type: :feature do
  let(:pool) { create(:pool) }
  let(:user) { pool.user }
  let(:question_text) { "Who will win Superb Owl 55?" }

  before { login_as(user, scope: :user) }

  describe "can create a question without any choices" do
    it "creates a question and redirects back to pool path" do
      visit pool_path(pool)

      fill_in "Question text", with: question_text
      click_button "Create Question!"

      expect(page).to have_content(question_text)
    end
  end

  describe "with choices" do
    let(:choice_one) { "Kansas City Chiefs" }

    describe "can create a question with at least 2 choices" do
      let(:choice_two) { "Tampa Bay Buccaneers" }

      it "creates a question with 2 choices and redirects back to pool path" do
        visit pool_path(pool)

        fill_in "Question text", with: question_text
        fill_in "question_choices_attributes_0_text", with: choice_one
        fill_in "question_choices_attributes_1_text", with: choice_two
        click_button "Create Question!"

        expect(page).to have_content(question_text)
        expect(page).to have_content(choice_one)
        expect(page).to have_content(choice_two)
      end
    end

    describe "cannot create a question with 1 choice" do
      it "does not create a question or chocies and redirects back to pool path" do
        visit pool_path(pool)

        fill_in "Question text", with: question_text
        fill_in "question_choices_attributes_0_text", with: choice_one
        click_button "Create Question!"

        expect(page.body.downcase).to have_content(pool.name.downcase)
        expect(page).not_to have_content(question_text)
        expect(page).not_to have_content(choice_one)
      end
    end
  end

  describe "can create a question with more than 2 choices"
end
