class Train < ApplicationRecord
  belongs_to :current_station, class_name: 'RailwayStation', foreign_key: :current_station_id
  belongs_to :route
  has_many :tickets
  has_many :wagons

  validates :number, presence: true

  def capacity_by_type(wagon_type, place_type)
    Wagon.where(type: wagon_type, train: self).sum(place_type) || 0
  end

  def ordered_wagons
    self.order_from_tail ? wagons.ordered.reverse_order : wagons.ordered
  end
end
