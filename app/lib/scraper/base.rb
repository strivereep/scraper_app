# frozen_string_literal: true

require 'open-uri'

module Scraper
  class Base
    attr_reader :crawler, :product

    def initialize(product_id)
      @product = Product.find_by(id: product_id)
      @crawler = Nokogiri::HTML(RestClient.get(product.url))
    end

    def scrape_content_and_save
      scrape
      category = Category.find_or_create_by(name: scraped_data[:category])

      # avoid duplicates association
      if product.categories.find { |c| c.name == category.name }.blank?
        product.categories << category
      end

      # active storage creates the new images and associates with the product
      # remove the existing images first
      product_images.destroy_all unless product_images.count.zero?

      scraped_data[:images].each do |image|
        product_image = URI.parse(image).open
        product.images.attach(
          io: product_image,
          filename: scraped_data[:title]
        )
      end

      product.update!(
        scraped_data.except(:category, :images)
      )
      product.reload
    end


    private

    def product_images
      @product_images ||= product.images
    end
  end
end
