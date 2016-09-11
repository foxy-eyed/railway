class Train < ApplicationRecord
  belongs_to :current_station, class_name: 'RailwayStation', foreign_key: :current_station_id
  belongs_to :route
  has_many :tickets
  has_many :wagons

  validates :number, presence: true

  def capacity_by_categories
    capacity = {}
    Wagon::CATEGORIES.each_key { |key| capacity[key] = { wagons: 0, top_places: 0, bottom_places: 0 } }
    wagons.each do |wagon|
      category = wagon.category.to_sym
      capacity[category][:wagons] += 1
      capacity[category][:top_places] += wagon.top_places
      capacity[category][:bottom_places] += wagon.bottom_places
    end
    capacity
  end
end
