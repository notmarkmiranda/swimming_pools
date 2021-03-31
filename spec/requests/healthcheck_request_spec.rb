require "rails_helper"

describe Api::V1::HealthcheckController, type: :request do
  describe "GET#show" do
    subject(:get_show) { get api_v1_healthcheck_path }
    let(:message) { { "message" => "all is well, check again later." } }

    before { get_show }
    it "returns 200 status" do
      expect(response).to have_http_status(200)
    end

    it "returns something in the body" do
      expect(JSON.parse(response.body)).to eq(message)      
    end
  end
end