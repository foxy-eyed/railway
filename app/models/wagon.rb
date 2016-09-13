class Wagon < ApplicationRecord
  belongs_to :train

  scope :coupe, -> { where(type: 'CoupeWagon') }
  scope :economy, -> { where(type: 'EconomyWagon') }
  scope :lux, -> { where(type: 'LuxWagon') }
  scope :sitting, -> { where(type: 'SittingWagon') }

  scope :ordered_by_train, -> { order(:number) }
  scope :ordered_by_train, -> { joins(:train).order('trains.number, wagons.number') }

  validates :train_id, presence: true
  validates :number, numericality: { only_integer: true, greater_than: 0 }
  validates :number, uniqueness: true

  def self.types
    { 'Coupe' => :CoupeWagon, 'Economy' => :EconomyWagon, 'Lux' => :LuxWagon, 'Sitting' => :SittingWagon}
  end

  def self.permitted_params
    [:type, :train_id, :number]
  end
end
