class ExtendWagons < ActiveRecord::Migration[5.0]
  def change
    change_table :wagons do |t|
      t.rename :category, :type
      t.integer :side_top_places, default: 0
      t.integer :side_bottom_places, default: 0
      t.integer :seats, default: 0
      t.integer :number
    end
  end
end
