class Route < ApplicationRecord
  has_many :trains
  has_many :railway_stations_routes
  has_many :railway_stations, through: :railway_stations_routes

  validates :name, presence: true
  validate :stations_count

  before_validation :set_name
  before_create :order_stations

  private

  def set_name
    self.name = "#{railway_stations.first.title} — #{railway_stations.last.title}"
  end

  def order_stations
    railway_stations_routes.each_with_index do |item, position|
      item.position = position
    end
  end

  def stations_count
    errors.add(:base, 'Route should contain at least 2 stations') if railway_stations.size < 2
  end
end
