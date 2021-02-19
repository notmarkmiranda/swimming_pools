require "rails_helper"

describe DashboardController, type: :request do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe "GET#show" do
    subject(:get_show) { get dashboard_path }

    it "has 200 status" do
      get_show

      expect(response).to have_http_status(200)
    end
  end
end
