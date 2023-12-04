# frozen_string_literal: true

class ScraperJob
  include Sidekiq::Job
  include Sidekiq::Lock::Worker

  sidekiq_options lock: {
    timeout: proc { |args| 3000 },
    name:    proc { |args | "lock:perproduct:#{args[0]}" },
    value:   proc { |args| "#{args[0]}" }
  }

  def perform(*args)
    if lock.acquire!
      begin
        product = Product.find_by(id: args[0])
        return unless product.present?

        # split the url and classify the domain name
        host_name = URI(product.url).host.split('.')[1].classify
        "Scraper::#{host_name}".safe_constantize.new(product.id).scrape_content_and_save
      ensure
        lock.release!
      end
    else
      # reschedule, raise an error or do whatever you want
      puts "skipping duplicate scrapper for product #{args[0]}"
    end
  end
end
