class Wagon < ApplicationRecord
  TYPES = { CoupeWagon: 'Coupe', EconomyWagon: 'Economy', LuxWagon: 'Lux', SittingWagon: 'Sitting' }.freeze
  PLACE_TYPES = { bottom_places: 'Bottom', top_places: 'Top', side_bottom_places: 'Side bottom',
                  side_top_places: 'Side top', seats: 'Seats' }.freeze

  belongs_to :train

  validates :train_id, presence: true
  validates :number, numericality: { only_integer: true, greater_than: 0 }
  validates :number, uniqueness: { scope: :train_id }

  before_validation :set_number, on: :create

  scope :ordered, -> { order(:number) }
  scope :ordered_by_train, -> { joins(:train).order('trains.number, wagons.number') }

  def self.types
    TYPES.invert
  end

  def self.permitted_params
    [:type, :train_id, :number]
  end

  def type_label
    TYPES.fetch(type.to_sym)
  end

  protected

  def set_number
    max_number = train.wagons.maximum(:number) || 0
    self.number = max_number + 1
  end
end
