class LuxWagon < Wagon
  validates :bottom_places, numericality: { only_integer: true, greater_than: 0 }

  def self.permitted_params
    super.insert(-1, [:bottom_places])
  end
end
