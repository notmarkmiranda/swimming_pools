require "rails_helper"

describe PagesController, type: :request do
  describe 'GET#root' do
    subject(:get_home) { get root_path }

    it 'has 200 status' do
      get_home

      expect(response).to have_http_status(200)
    end
  end
end
