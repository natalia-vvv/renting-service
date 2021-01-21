class City < ApplicationRecord
  has_many :users

  def get_items
    users.map { |user| user.items }
  end
end
