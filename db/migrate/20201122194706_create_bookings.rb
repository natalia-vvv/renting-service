class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.references :client, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
