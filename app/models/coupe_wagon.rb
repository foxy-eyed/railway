class CoupeWagon < Wagon
  validates :top_places, :bottom_places, numericality: { only_integer: true, greater_than: 0 }

  def self.permitted_params
    super.insert(-1, [:top_places, :bottom_places])
  end
end
