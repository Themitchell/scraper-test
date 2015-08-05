require_relative '../../../lib/scraper/list_scraper'

RSpec.describe ListScraper do

  let(:request_url)        { 'http://www.wegottickets.com/searchresults/all' }
  let(:page_2_request_url) { 'http://www.wegottickets.com/searchresults/page/2/all' }
  let(:listing_url)        { 'http://www.wegottickets.com/event/312261' }

  let(:listing_page_without_next_link)  { File.read(File.join('spec', 'support', 'example_listing_page_2.html')) }
  let(:listing_page_with_next_link)     { File.read(File.join('spec', 'support', 'example_listing.html')) }
  let(:individual_listing_page)         { File.read(File.join('spec', 'support', 'example_individual_listing.html')) }

  subject(:scraper)        { ListScraper.new(request_url) }

  before do
    FakeWeb.register_uri(
      :get,
      request_url,
      body: listing_page_without_next_link,
      content_type: 'text/html'
    )

    FakeWeb.register_uri(
      :get,
      listing_url,
      body: individual_listing_page,
      content_type: 'text/html'
    )
  end

  describe 'when there is only 1 page of results' do
    it 'finds only one result' do
      events = scraper.run

      expect(events.count).to eq(1)
    end

    it 'returns a list of event objects' do
      events = scraper.run

      expect(events.size).to eq(1)
      expect(events.first.artist).to eq('ALVIN YOUNGBLOOD HART')
      expect(events.first.venue).to eq('Pier')
      expect(events.first.town).to eq('WORTHING : ')
      expect(events.first.date).to eq('WED 5TH AUG, 2015 Doors open 7pm Show starts 8pm')
      expect(events.first.price).to eq('Â£16.50')
    end
  end

  describe 'when there are multiple pages of results' do
    before do
      FakeWeb.register_uri(
        :get,
        request_url,
        body: listing_page_with_next_link,
        content_type: 'text/html'
      )

      FakeWeb.register_uri(
        :get,
        page_2_request_url,
        body: listing_page_without_next_link,
        content_type: 'text/html'
      )
    end

    it 'finds 2 results (one for each page)' do
      events = scraper.run

      expect(events.count).to eq(2)
    end
  end
end
