require 'mechanize'
require_relative './event'

class ListScraper
  def initialize(url)
    @url = url
  end

  def run
    listing_pages.inject([]) do |events, page|
      subset_of_events = page.search('.ListingOuter').map do |event_element|
        event_link = event_element.search('.event_link').first
        event_page = agent.get(event_link[:href])

        Event.new(
          event_link.text,
          event_element.search('.venuetown').text,
          event_element.search('.venuename').text,
          event_page.search('.VenueDetails h2').text,
          event_element.search('.searchResultsPrice strong').text
        )
      end

      events += subset_of_events
    end
  end

private
  attr_reader :url

  def agent
    @agent ||= Mechanize.new
  end

  def start_page
    @start_page ||= agent.get(url)
  end

  def next_page_link(page)
    page.search('.nextlink').first
  end

  def get_page(url)
    agent.get(url)
  end

  def listing_pages
    return @listing_pages if @listing_pages

    @listing_pages ||= [start_page]

    loop do
      break unless next_page_link(@listing_pages.last)
      @listing_pages << get_page(next_page_link(@listing_pages.last)[:href])
    end

    @listing_pages
  end
end
