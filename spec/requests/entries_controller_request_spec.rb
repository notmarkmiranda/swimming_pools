require "rails_helper"

describe EntriesController, type: :request do
  let(:pool) { create(:pool) }
  let(:user) { pool.user }
  
  before { sign_in(user) }
  describe "POST#create" do
    subject(:post_create) { post pool_entries_path(pool)}

    describe "Success" do
      it "has 302 status" do
        post_create
        
        expect(response).to have_http_status(302)
      end

      it "creates an entry" do
        expect { post_create }.to change(Entry, :count).by(1)
      end
    end

    describe "Failure" do
      before do
        pool.update(multiple_entries: false)
        create(:entry, pool: pool, user: user)
      end
      
      it "redirects has 302 status" do
        post_create

        expect(response).to have_http_status(302)
      end

      it "does not create an entry" do
        expect { post_create }.not_to change(Entry, :count)
      end
    end
  end
end