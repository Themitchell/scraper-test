require_relative '../../../lib/scraper/list_scraper'

RSpec.describe ListScraper do

  let(:request_url) { 'http://www.wegottickets.com/searchresults/all' }
  let(:link1) { double(:link) }
  let(:link2) { double(:link) }
  let(:links) { [link1, link2]}
  let(:page)  { double(:page) }
  subject(:scraper) { ListScraper.new(request_url) }

  let(:mechanize) { double(:mechanize) }

  before do
    expect(Mechanize).to receive(:new).and_return(mechanize)
    expect(mechanize).to receive(:get).with(request_url).and_return(page)
    expect(page).to receive(:links_with).and_return(links)
  end

  it 'creates a scraper object' do
    scraper.run
  end

  it 'returns a list of page links for individual listings' do
    expect(scraper.run).to eq(links)
  end
end
