class CreateWagons < ActiveRecord::Migration[5.0]
  def change
    create_table :wagons do |t|
      t.string :category
      t.integer :top_places
      t.integer :bottom_places
      t.belongs_to :train

      t.timestamps
    end
  end
end
