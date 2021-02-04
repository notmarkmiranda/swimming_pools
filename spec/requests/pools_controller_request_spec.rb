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

  describe "GET#edit" do
    let(:pool) { create(:pool, user: user) }

    subject(:get_edit) { get edit_pool_path(pool) }

    it "has 200 status" do
      get_edit

      expect(response).to have_http_status(200)
    end
  end

  describe "PUT#update" do
    let(:pool) { create(:pool, user: user) }
    let(:new_name) { pool.name.reverse }

    subject(:put_update) { put pool_path(pool), params: { pool: attrs } }

    describe "success" do
      let(:attrs) { { name: new_name } }

      it "has 302 status" do
        put_update

        expect(response).to have_http_status(302)
      end

      it "updates pool" do
        expect { put_update }.to change { pool.reload; pool.name }
      end
    end

    describe "failure" do
      let(:attrs) { { name: "" } }

      it "has 200 status" do
        put_update

        expect(response).to have_http_status(200)
      end

      it "does not update pool" do
        expect { put_update }.not_to change { pool.reload; pool.name }
      end
    end
  end
end
