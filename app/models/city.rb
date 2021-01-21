class City < ApplicationRecord
  has_many :users

  def self.get_items(city)
    city.users.map { |user| user.items if user.city == city.name }
  end
end
