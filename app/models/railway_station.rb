class RailwayStation < ApplicationRecord
  has_many :trains, class_name: 'Train', foreign_key: :current_station_id
  has_many :tickets_departure, class_name: 'Ticket', foreign_key: :start_station_id
  has_many :tickets_arrival, class_name: 'Ticket', foreign_key: :end_station_id
  has_many :railway_stations_routes
  has_many :routes, through: :railway_stations_routes

  validates :title, presence: true

  scope :ordered, -> { joins(:railway_stations_routes).uniq.order('railway_stations_routes.position') }
  scope :ordered_by_title, -> { order(:title) }

  def position_in(route)
    route_assignment(route).try(:position)
  end

  def update_position(route, position)
    route_assignment = route_assignment(route)
    route_assignment && route_assignment.update(position: position)
  end

  protected

  def route_assignment(route)
    @route_assignment ||= railway_stations_routes.find_by(route: route)
  end
end
