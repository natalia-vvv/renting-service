class User < ApplicationRecord
  belongs_to :city

  has_many :items, class_name: 'Item', foreign_key: :owner_id, inverse_of: 'owner'
  has_many :bookings, foreign_key: :client_id, inverse_of: 'client'
  has_many :written_reviews, class_name: 'Review', foreign_key: :reviewer_id, inverse_of: 'reviewer'
  has_many :received_reviews, class_name: 'Review', as: :reviewable

  def booked_items
    Item.joins(:bookings).where("client_id = #{self.id}")
  end

  def owners_of_booked_items
    User.where(id: Item.select(:owner_id).where(id: booked_items))
  end
end

# SELECT * FROM users Where users.id IN (SELECT owner_id FROM items WHERE items.id IN...)

# SELECT * FROM items INNER JOIN bookings ON items WHERE booking.client_id = x
# SELECT * FROM users INNER JOIN items ON items.owner_id = id INNER JOIN bookings ON items WHERE booking.client_id = x
