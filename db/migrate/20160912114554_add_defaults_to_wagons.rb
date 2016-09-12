class AddDefaultsToWagons < ActiveRecord::Migration[5.0]
  def change
    change_column_default :wagons, :top_places, 0
    change_column_default :wagons, :bottom_places, 0
  end
end
