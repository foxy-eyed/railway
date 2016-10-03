class RailwayStation < ApplicationRecord
  has_many :trains, class_name: 'Train', foreign_key: :current_station_id
  has_many :tickets_departure, class_name: 'Ticket', foreign_key: :start_station_id
  has_many :tickets_arrival, class_name: 'Ticket', foreign_key: :end_station_id
  has_many :railway_stations_routes
  has_many :routes, through: :railway_stations_routes

  validates :title, presence: true

  scope :ordered, -> { select('railway_stations.*, railway_stations_routes.position').joins(:railway_stations_routes).uniq.order('railway_stations_routes.position') }
  scope :ordered_by_title, -> { order(:title) }

  def within_route(route, attribute)
    get_route_connection(route).try(attribute)
  end

  def update_within_route(route, position, arrival_time, departure_time)
    route_connection = get_route_connection(route)
    if route_connection
      route_connection.update(position: position, arrival_time: arrival_time, departure_time: departure_time)
    end
  end

  protected

  def get_route_connection(route)
    @route_connection ||= Hash.new do |h, route_id|
      h[route_id] = railway_stations_routes.find_by(route_id: route_id)
    end
    @route_connection[route.id]
  end
end
