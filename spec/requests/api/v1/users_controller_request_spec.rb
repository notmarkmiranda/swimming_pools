require "rails_helper"

describe Api::V1::UsersController, type: :request do
  describe "POST#create" do
  subject(:post_create) { post "/api/v1/users", params: user_attrs }
  
    describe "happy path" do
      let(:user_attrs) { attributes_for(:user) }

      it "creates a user" do
        expect { post_create }.to change(User, :count).by(1)
      end

      it "returns a JSON payload with user attributes" do
        post_create

        json_response = JSON.parse(response.body)
        expect(json_response["data"].keys).to match_array(["id", "type", "attributes"])
        expect(json_response["data"]["attributes"].keys).to match_array(["email", "first_name", "last_initial", "token"])
      end
    end

    describe "sad path" do
      let(:user_attrs) { attributes_for(:user).except(:email) }
      
      it "does not create a user" do
        expect { post_create }.not_to change(User, :count)
      end

      it "returns JSON payload with errors" do
        post_create

        json_response = JSON.parse(response.body)

        expect(json_response["errors"]["details"]).to match_array(["Email can't be blank"])
      end
    end
  end

  describe "POST#login" do
    let(:user) { create(:user) }
    subject(:post_login) { post "/api/v1/login", params: { email: user.email, password: "password" } }

    it "returns a JSON payload with user attributes" do
      post_login

      json_response = JSON.parse(response.body)

      expect(json_response["data"].keys).to match_array(["id", "type", "attributes"])
      expect(json_response["data"]["attributes"].keys).to match_array(["email", "first_name", "last_initial", "token"])
    end
  end

  describe "GET#auto_login"
  # i'm not sure what this endpoint does

end