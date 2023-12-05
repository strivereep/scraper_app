# frozen_string_literal: true

class SchedulerScraperJob
  include Sidekiq::Job

  LOOKUP_DATE = 7.days.freeze

  def perform
    puts '**************************'
    # fetch all the products having categories associated with it
    # and having updated_at more than a week
    products = Product
      .joins(:categories)
      .distinct
      .where('date(products.updated_at) <= ?', LOOKUP_DATE.ago.to_date)
    return if products.count.zero?

    products.each do |product|
      puts '**************************'
      puts "Refetching Product attributes for #{product.id}"
      ScraperJob.perform_async(product.id)
    end
  end
end
