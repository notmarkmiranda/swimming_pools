require "rails_helper"

describe MembershipsController, type: :request do
  describe "POST#create" do
    let(:pool) { create(:pool) }

    subject(:post_create) { post memberships_path, params: { membership: attrs } }

    before { sign_in(pool.user) }

    describe "success" do
      let(:attrs) { attributes_for(:membership).merge!(invite_code: pool.invite_code, pool_id: pool.id) }

      it "has 302 response" do
        post_create

        expect(response).to have_http_status(302)
      end

      it "creates a membership" do
        expect { post_create }.to change(Membership, :count).by(1)
      end
    end

    describe "failure" do
      describe "when user already exists in pool" do
        before { create(:membership, pool: pool, user: pool.user) }

        let(:attrs) { attributes_for(:membership).merge!(invite_code: pool.invite_code, pool_id: pool.id) }

        it "has 302 status" do
          post_create

          expect(response).to have_http_status(302)
        end

        it "does not create a membership" do
          expect { post_create }.not_to change(Membership, :count)
        end
      end

      describe "when invite code is incorrect" do
        let(:attrs) { attributes_for(:membership).merge!(invite_code: pool.invite_code.reverse, pool_id: pool.id) }

        it "has 302 response" do
          post_create

          expect(response).to have_http_status(302)
        end

        it "creates a membership" do
          expect { post_create }.not_to change(Membership, :count)
        end
      end
    end
  end
end
