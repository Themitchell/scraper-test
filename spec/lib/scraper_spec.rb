require_relative '../../lib/scraper'

RSpec.describe Scraper do

  let(:request_url) { 'http://www.wegottickets.com/searchresults/all' }
  subject(:scraper) { Scraper.new(request_url) }

  it 'creates a scraper object' do
    scraper.run
  end
end
