class CSVWriter

  def initialize(events)
    @events = events
  end

  def write
    write_events_to_csv
  end

private
  attr_reader :events

  def write_events_to_csv
    CSV.open(filename, "wb") do |csv|
      events.each do |event|
        csv << event.to_csv
      end
    end
  end

  def filename
    "tmp/listings_#{Time.now.to_i}.csv"
  end
end
