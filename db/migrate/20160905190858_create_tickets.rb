class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :serial_number

      t.timestamps
    end
  end
end
