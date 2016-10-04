class AddIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :railway_stations_routes, [:railway_station_id, :route_id], unique: true, name: 'pair_unique'
    add_index :wagons, [:id, :type]
  end
end
