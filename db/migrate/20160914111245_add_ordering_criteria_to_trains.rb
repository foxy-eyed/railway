class AddOrderingCriteriaToTrains < ActiveRecord::Migration[5.0]
  def change
    add_column :trains, :order_from_tail, :boolean, default: false
  end
end
