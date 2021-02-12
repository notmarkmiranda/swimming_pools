require "rails_helper"

describe PicksController, type: :request do
  describe "POST#create" do
    subject(:post_create) { post picks_path, params: attrs }

    describe "success" do
      let(:entry) { create(:entry) }
      let(:choice) { create(:choice) }
      let(:attrs) { { pick: { entry_id: entry.id, choice_id: choice.id } } }

      it "has 302 status" do
        post_create

        expect(response).to have_http_status(302)
      end

      it "creates a pick" do
        expect { post_create }.to change(Pick, :count).by(1)
      end
    end

    describe "failure"
  end
end
