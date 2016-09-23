class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tickets

  validates :last_name, presence: true
  validates :first_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
