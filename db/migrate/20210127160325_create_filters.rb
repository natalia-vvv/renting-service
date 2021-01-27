class CreateFilters < ActiveRecord::Migration[5.1]
  def change
    create_table :filters do |t|
      t.string :name
      t.references :category, null: true, foreign_key: true

      t.timestamps
    end
  end
end
