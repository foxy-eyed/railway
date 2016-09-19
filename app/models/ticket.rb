class Ticket < ApplicationRecord
  belongs_to :train
  belongs_to :start_station, class_name: 'RailwayStation', foreign_key: :start_station_id
  belongs_to :end_station, class_name: 'RailwayStation', foreign_key: :end_station_id
  belongs_to :user

  validates :serial_number, :passenger_name, :passport_number, presence: true

  before_validation :gen_serial_number, on: :create
  before_validation :set_user, on: :create

  private

  def gen_serial_number
    @serial_number = rand(9**10).to_s
  end

  def set_user
    @user_id = User.first.id
  end
end
