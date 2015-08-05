require_relative '../../lib/scraper'

RSpec.describe Scraper do

  let(:request_url) { 'http://www.wegottickets.com/searchresults/all' }

  subject(:scraper) { Scraper.new(request_url) }

  it 'runs the scraper and calls the listing and event scrapers' do
    list_scraper = double(:list_scraper, run: nil)
    expect(ListScraper).to receive(:new).and_return(list_scraper)
    expect(list_scraper).to receive(:run)

    scraper.run
  end
end
