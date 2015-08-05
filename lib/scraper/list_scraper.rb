require 'mechanize'

class ListScraper
  def initialize(url)
    @url = url
  end

  def run
    agent.links_with(class: 'event_link')
  end

private
  attr_reader :url

  def agent
    @scraper ||= Mechanize.new.get(url)
  end
end
