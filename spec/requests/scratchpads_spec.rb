require 'rails_helper'

RSpec.describe "Scratchpads", type: :request do
  describe "GET /scratchpads" do
    it "works! (now write some real specs)" do
      get scratchpads_path
      expect(response).to have_http_status(200)
    end
  end
end
