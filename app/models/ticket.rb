class Ticket < ApplicationRecord
  belongs_to :train
  belongs_to :start_station, class_name: 'RailwayStation', foreign_key: :start_station_id
  belongs_to :end_station, class_name: 'RailwayStation', foreign_key: :end_station_id
  belongs_to :user

  validates :serial_number, :passenger_name, :passport_number, presence: true
  validates :passenger_name, length: { minimum: 3, maximum: 50 }
  validates :passport_number, format: { with: /\A[[:digit:]]{4}[\s]+[[:digit:]]{6}\z/ }

  before_validation :gen_serial_number, on: :create

  private

  def gen_serial_number
    self.serial_number = rand(9**10).to_s
  end
end
