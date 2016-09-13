class RailwayStation < ApplicationRecord
  has_many :trains, class_name: 'Train', foreign_key: :current_station_id
  has_many :tickets_departure, class_name: 'Ticket', foreign_key: :start_station_id
  has_many :tickets_arrival, class_name: 'Ticket', foreign_key: :end_station_id
  has_many :railway_stations_routes
  has_many :routes, through: :railway_stations_routes

  scope :ordered, -> { joins(:railway_stations_routes).uniq.order('railway_stations_routes.position') }
  scope :ordered_by_title, -> { order(:title) }

  validates :title, presence: true

  def route_assignment(route)
    RailwayStationsRoute.find_by(route: route, railway_station: self)
  end
end
