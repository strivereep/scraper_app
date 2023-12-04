require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "POST /api/products" do
    let(:params) do
      {
        product: {
          url: 'https://www.flipkart.com/srpm-wayfarer-sunglasses/p/itmaf19ae5820c06'
        }
      }
    end

    it "creates the product" do
      before_product_count = Product.count
      post api_products_path, params: params
      expect(response).to have_http_status(201)
      expect(Product.count).to eq before_product_count + 1
      response_json = JSON.parse(response.body)
      %w[id url title price description mobile_number size categories].each do |k|
        expect(response_json.keys).to include k
      end
    end
  end

  describe 'PUT /api/products/:id' do
    let(:product) { create(:product) }
    let(:url) { 'https://www.flipkart.com/realme-c51-carbon-black-64-gb/p/itm0e93bcb87927f?pid=MOBGSQGGZ7HQMEZD&lid=LSTMOBGSQGGZ7HQMEZDQMM5MX&marketplace=FLIPKART&store=tyy%2F4io&srno=b_1_3&otracker=nmenu_sub_Electronics_0_Realme&fm=organic&iid=57a5a629-57f9-4708-8e13-6978af9de952.MOBGSQGGZ7HQMEZD.SEARCH&ppt=pp&ppn=pp&ssid=ukhx2lpu680000001701679290403' }
    let(:params) do
      {
        product: {
          url: url
        }
      }
    end

    before { product }

    it 'updates the product' do
      put "/api/products/#{product.id}", params: params
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['url']).to eq url
    end
  end

  describe 'delete /api/products/:id' do
    let(:product) { create(:product) }

    before { product }

    it 'deletes/destroys the product' do
      before_product_count = Product.count
      delete "/api/products/#{product.id}"
      expect(response).to have_http_status(204)
      expect(Product.count).not_to eq before_product_count
    end
  end
end
