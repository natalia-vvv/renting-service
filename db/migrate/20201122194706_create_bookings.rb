class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.references :item, null: false, foreign_key: true
      t.references :user, null:false, foreign_key: true

      t.timestamps
    end
  end
end
