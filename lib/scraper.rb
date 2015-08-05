require_relative './scraper/list_scraper'

class Scraper

  def initialize(url)
    @url = url
  end

  def run
    scraped_listings
  end

private
  attr_reader :url

  def scraped_listings
    @scraped_listings ||= ListScraper.new(url).run
  end
end
