# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :category, null: true, foreign_key: true

      t.timestamps
    end
  end
end
