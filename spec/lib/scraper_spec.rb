require 'timecop'
require_relative '../../lib/scraper'

RSpec.describe Scraper do

  let(:request_url) { 'http://www.wegottickets.com/searchresults/all' }

  subject(:scraper) { Scraper.new(request_url) }

  it 'runs the scraper and calls the listing and event scrapers' do
    list_scraper = double(:list_scraper, run: [])
    expect(ListScraper).to receive(:new).and_return(list_scraper)

    scraper.run
  end

  it 'creates a csv file with the timestamp in the name' do
    time = Time.now
    Timecop.freeze(time) do
      scraper.run
      expect(File.exists?("tmp/listings_#{time.to_i}.csv")).to eq(true)
    end
  end
end
