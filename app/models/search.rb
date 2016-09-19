class Search
  include ActiveModel::Model

  attr_accessor :start_station_id, :end_station_id
  attr_reader :result, :start_station, :end_station

  validates :start_station_id, :end_station_id, presence: true

  def run
    @start_station = RailwayStation.find(start_station_id)
    @end_station = RailwayStation.find(end_station_id)
    @result = Train.includes(route: :railway_stations).where(railway_stations: { id: start_station_id }) &
        Train.includes(route: :railway_stations).where(railway_stations: { id: end_station_id })
  end
end
