# frozen_string_literal: true

require 'rails_helper'

describe Scraper::Flipkart do
  let(:product) { create(:product) }
  let(:subject) { described_class.new(product.id) }

  describe '#scrape_content_and_save' do
    it 'scrapes the url, creates association with categories and saves the attributes for product' do
      before_category_count = Category.count
      subject.scrape_content_and_save
      product.reload
      expect(product.title).not_to be_nil
      expect(product.description).not_to be_nil
      expect(product.price).not_to be_nil
      expect(product.size).not_to be_nil
      expect(product.images.count).not_to be_zero
      expect(Category.count).to eq before_category_count + 1
      expect(product.categories).to be_present
    end
  end
end
