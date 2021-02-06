require "rails_helper"

describe QuestionsController, type: :request do
  let(:pool) { create(:pool) }
  let(:user) { pool.user }

  before { sign_in(user) }

  describe "POST#create" do
    subject(:post_create) { post questions_path, params: attrs }
    
    describe "success" do
      let(:attrs) { { question: { text: "Question text", pool_id: pool.id } } }

      it "has 302 status" do
        post_create
        
        expect(response).to have_http_status(302)
      end

      it "creates a new question" do
        expect { post_create }.to change(Question, :count).by(1)
      end
    end

    describe "failure" do
      let(:attrs) { { question: { text: "", pool_id: pool.id } } }

      it "has 302 status" do
        post_create
        
        expect(response).to have_http_status(302)
      end

      it "does not create a new question" do
        expect { post_create }.not_to change(Question, :count)
      end
    end
  end
end