require 'rails_helper'

RSpec.describe "Companys", type: :request do
  describe "GET /companies" do
    it "works! (now write some real specs)" do
      get companies_path
      expect(response).to have_http_status(200)
    end
  end
end
