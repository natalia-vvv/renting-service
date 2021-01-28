class CreateItemOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :item_options, id: false do |t|
      t.references :item, null: false, foreign_key: true
      t.references :option, null: false, foreign_key: true

      t.timestamps
    end
  end
end
