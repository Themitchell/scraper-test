class Event < Struct.new(
  :artist,
  :town,
  :venue,
  :date,
  :price)

  def to_csv
    [artist, town, venue, date, price]
  end
end
