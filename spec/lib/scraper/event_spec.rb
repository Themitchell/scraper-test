require_relative '../../../lib/scraper/event'

RSpec.describe Event do

  let(:artist) { 'My Event' }
  let(:town) { 'London' }
  let(:venue) { 'Hammersmith Apollo' }
  let(:date) { '01-01-2001' }
  let(:price) { '£15' }

  let(:event) {
    Event.new(
      artist,
      town,
      venue,
      date,
      price
    )
  }

  describe '#to_csv' do
    subject { event.to_csv }

    it 'returns the values as an array for a CSV' do
      expect(subject).to eq([
        artist,
        town,
        venue,
        date,
        price
      ])
    end
  end
end
