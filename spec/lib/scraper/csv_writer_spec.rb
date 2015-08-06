require 'timecop'
require_relative '../../../lib/scraper/csv_writer'

RSpec.describe CSVWriter do

  let(:event) { double(:event, to_csv: ['some', 'data', 'here']) }
  subject(:csv_writer) { CSVWriter.new([event]) }

  it 'creates a csv file with the timestamp in the name' do
    time = Time.now
    Timecop.freeze(time) do
      csv_writer.write
      expect(File.exists?("tmp/listings_#{time.to_i}.csv")).to eq(true)
    end
  end
end
