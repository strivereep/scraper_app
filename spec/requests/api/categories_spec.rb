require 'swagger_helper'

RSpec.describe 'api/categories', type: :request do
  path '/api/categories' do
    get('list categories') do
      tags 'categories'
      consumes 'application/json'
      response '200', 'lists categories' do
        schema type: :array,
          properties: {
            categories: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  name: { type: :string },
                  products: {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        url: { type: :string },
                        title: { type: :string },
                        size: { type: :string },
                        description: { type: :text },
                        price: { type: :string },
                        mobile_number: { type: :string },
                        product_images: { type: :array }
                      },
                      required: %w[id url title size description price mobile_number product_images]
                    }
                  }
                },
                required: %w[id name products]
              }
            }
          },
          required: ['categories']

        # let(:category) { create(:category) }
        # let(:product) { create(:product) }
        # it do
        #   product.categories << category
        #   product.reload
        # end

        run_test!
      end
    end
  end
end
