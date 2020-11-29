class CreateUserReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :user_reviews do |t|
      t.string :reviewer
      t.text :message
      t.references :reviewer_id, null: false, foreign_key: { to_table: 'users'}
      t.references :item_owner_id, null: false, foreign_key: { to_table: 'users'}

      t.timestamps
    end
  end
end
