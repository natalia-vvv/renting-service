class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :message
      t.references :reviewer, null: false, foreign_key: { to_table: :users }
      t.references :reviewable, polymorphic: true

      t.timestamps
    end
  end
end
