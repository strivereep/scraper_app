require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /api/categories" do
    let(:category1) { create(:category) }
    let(:category2) { create(:category, name: 'Mobile') }

    before do
      category1
      category2
    end

    it 'displays all the categories' do
      get api_categories_path
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).count).to eq 2
    end
  end
end
