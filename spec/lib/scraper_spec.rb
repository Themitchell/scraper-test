require 'timecop'
require_relative '../../lib/scraper'

RSpec.describe Scraper do

  let(:request_url)   { 'http://www.wegottickets.com/searchresults/all' }
  let(:events)        { [] }
  let(:list_scraper)  { double(:list_scraper, run: events) }
  let(:csv_writer)    { double(:csv_writer) }

  subject(:scraper)   { Scraper.new(request_url) }

  before do
    allow(ListScraper).to receive(:new)
                            .and_return(list_scraper)
  end

  it 'calls the scraper' do
    expect(list_scraper).to receive(:run)
    scraper.run
  end

  it 'calls the csv writer and runs it with the events' do
    expect(CSVWriter).to receive(:new)
                            .with(events)
                            .and_return(csv_writer)
    expect(csv_writer).to receive(:write)
    scraper.run
  end
end
