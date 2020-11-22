class CreateItemReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :item_reviews do |t|
      t.string :reviewer
      t.text :message
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
