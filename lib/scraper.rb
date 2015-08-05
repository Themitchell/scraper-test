require 'csv'
require_relative './scraper/list_scraper'

class Scraper

  def initialize(url)
    @url = url
  end

  def run
    write_listings_to_csv
  end

private
  attr_reader :url

  def scraped_listings
    @scraped_listings ||= ListScraper.new(url).run
  end

  def write_listings_to_csv
    CSV.open(csv_filename, "wb") do |csv|
      scraped_listings.each do |event|
        csv << event.to_csv
      end
    end
  end

  def csv_filename
    "tmp/listings_#{Time.now.to_i}.csv"
  end
end
