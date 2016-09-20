class Search
  include ActiveModel::Model

  attr_accessor :start_station_id, :end_station_id
  attr_reader :result

  validates :start_station_id, :end_station_id, presence: true
  validate :stations_differ

  def start_station
    RailwayStation.find(start_station_id)
  end

  def end_station
    RailwayStation.find(end_station_id)
  end

  def run
    if self.valid?
      @result = Train.includes(route: :railway_stations).where(railway_stations: { id: start_station_id }) &
          Train.includes(route: :railway_stations).where(railway_stations: { id: end_station_id })
    end
  end

  private

  def stations_differ
    errors.add(:base, 'Stations must be different') if start_station_id == end_station_id
  end
end
