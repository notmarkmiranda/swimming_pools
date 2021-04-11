require "rails_helper"

describe Api::V1::UsersController, type: :request do
  describe "POST#create" do
    let(:user_attrs) { attributes_for(:user) }
    subject(:post_create) { post "/api/v1/users", params: user_attrs }

    it "creates a user" do
      expect { post_create }.to change(User, :count).by(1)
    end

    it "returns a JSON payload" do
      post_create

      json_response = JSON.parse(response.body)
      
      expect(json_response["data"].keys).to match_array(["id", "type", "attributes"])
      expect(json_response["data"]["attributes"].keys).to match_array(["email", "first_name", "last_initial", "token"])
    end
  end

  describe "POST#login"

  describe "GET#auto_login"

end