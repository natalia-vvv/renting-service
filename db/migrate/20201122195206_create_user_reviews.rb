class CreateUserReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :user_reviews do |t|
      t.string :reviewer
      t.text :message

      t.timestamps
    end
  end
end
