require 'swagger_helper'

RSpec.describe 'api/products', type: :request do

  path '/api/products' do

    post('create product') do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          url: { type: :string }
        },
        required: ['url']
      }

      response '201', 'product created' do
        let(:product) { { url: 'https://www.flipkart.com/srpm-wayfarer-sunglasses/p/itmaf19ae5820c06' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:product) { { url: '' } }
        run_test!
      end
    end
  end

  path '/api/products/{id}' do
    put('update product') do
      put 'Updates a product' do
        tags 'Products'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer
        parameter name: :product, in: :body, schema: {
          type: :object,
          properties: {
            url: { type: :string }
          },
          required: [ 'url' ]
        }

        response '200', 'product updated' do
          let(:id) { Product.create(url: 'http://example.com').id }
          let(:product) { { url: 'http://newexample.com' } }
          run_test!
        end

        response '404', 'product not found' do
          let(:id) { 'invalid' }
          let(:product) { { url: 'http://newexample.com' } }
          run_test!
        end

        response '422', 'invalid request' do
          let(:id) { Product.create(url: 'http://example.com').id }
          let(:product) { { url: '' } }
          run_test!
        end
      end
    end

    delete('delete product') do
      tags 'Products'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '204', 'product deleted' do
        let(:id) { Product.create(url: 'http://example.com').id }
        run_test!
      end

      response '404', 'product not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
