require 'mechanize'
require_relative './event'

class ListScraper
  def initialize(url)
    @url = url
  end

  def run
    page = agent.get(url)

    page.search('.ListingOuter').map do |listing|
      listing_link = listing.search('.event_link').first
      listing_page = agent.get(listing_link[:href])

      Event.new(
        listing_link.text,
        listing.search('.venuetown').text,
        listing.search('.venuename').text,
        listing_page.search('.VenueDetails h2').text,
        listing.search('.searchResultsPrice strong').text
      )
    end
  end

private
  attr_reader :url

  def agent
    @scraper ||= Mechanize.new
  end
end
