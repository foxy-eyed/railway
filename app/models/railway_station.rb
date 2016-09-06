class RailwayStation < ApplicationRecord
  has_many :trains
  has_many :tickets_departure, class_name: 'Ticket', foreign_key: :start_station_id
  has_many :tickets_arrival, class_name: 'Ticket', foreign_key: :end_station_id
  has_many :railway_stations_routes
  has_many :routes, through: :railway_stations_routes

  validates :title, presence: true
end
