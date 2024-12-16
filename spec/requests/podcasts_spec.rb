require 'rails_helper'

RSpec.describe "Podcasts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/podcasts/new"
      expect(response).to have_http_status(:success)
    end
  end
end
