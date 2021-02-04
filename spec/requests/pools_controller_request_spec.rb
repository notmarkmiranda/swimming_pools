require 'rails_helper'

describe PoolsController, type: :request do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe "GET#new" do
    subject(:get_new) { get new_pool_path }

    it "has 200 status" do
      get_new

      expect(response).to have_http_status(200)
    end
  end

  describe "POST#create" do
    let(:pool_attributes) { { pool: attrs } }
    subject(:post_create) { post pools_path, params: pool_attributes }

    describe "success" do
      let(:attrs) { attributes_for(:pool) }
      it "has 302 status" do
        post_create

        expect(response).to have_http_status(302)
      end

      it "creates a pool" do
        expect { post_create }.to change(Pool, :count).by(1)
      end
    end

    describe "failure" do
      let(:attrs) { { pool: { name: '' } } }

      it "has another status" do
        post_create

        expect(response).to have_http_status(200)
      end

      it "does not create a pool" do
        expect do
          post_create
        end.not_to change(Pool, :count)
      end
    end
  end
end
