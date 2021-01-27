class CreateOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :options do |t|
      t.string :value
      t.references :filter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
