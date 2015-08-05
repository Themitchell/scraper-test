require_relative '../../../lib/scraper/list_scraper'

RSpec.describe ListScraper do

  let(:request_url) { 'http://www.wegottickets.com/searchresults/all' }
  let(:listing_url) { 'http://www.wegottickets.com/event/312261' }
  subject(:scraper) { ListScraper.new(request_url) }

  before do
    FakeWeb.register_uri(
      :get,
      request_url,
      body: File.read(File.join('spec', 'support', 'example_listing.html')),
      content_type: 'text/html'
    )

    FakeWeb.register_uri(
      :get,
      listing_url,
      body: File.read(File.join('spec', 'support', 'example_individual_listing.html')),
      content_type: 'text/html'
    )
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
