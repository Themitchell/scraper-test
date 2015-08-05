require 'csv'
require_relative './scraper/list_scraper'
require_relative './scraper/csv_writer'

class Scraper

  def initialize(url)
    @url = url
  end

  def run
    csv_writer.write
  end

private
  attr_reader :url

  def scraped_listings
    @scraped_listings ||= ListScraper.new(url).run
  end

  def csv_writer
    CSVWriter.new(scraped_listings)
  end
end
