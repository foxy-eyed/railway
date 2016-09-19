class Search
  include ActiveModel::Model

  attr_accessor :start_station_id, :end_station_id
  attr_reader :result

  def run
    routes = Route.joins(:railway_stations).where(railway_stations: {id: start_station_id }) &
        Route.joins(:railway_stations).where(railway_stations: {id: end_station_id })
    @result = Train.where(route_id: routes)
  end
end