# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :city
  belongs_to :account

  has_many :items,
           class_name: 'Item',
           foreign_key: :owner_id,
           inverse_of: 'owner'
  has_many :bookings, foreign_key: :client_id, inverse_of: 'client'
  has_many :written_reviews,
           class_name: 'Review',
           foreign_key: :reviewer_id,
           inverse_of: 'reviewer'
  has_many :received_reviews, class_name: 'Review', as: :reviewable
  has_many :booked_items, class_name: 'Item',
                          source: 'item', through: :bookings
  has_many :owners_of_booked_items, class_name: 'User',
                                    source: 'owner', through: :booked_items

  validates :first_name, :last_name, presence: true
end

# SELECT * FROM users Where users.id IN (SELECT owner_id FROM items WHERE items.id IN...)

# SELECT * FROM items INNER JOIN bookings ON items WHERE booking.client_id = x
#  Item.joins(:bookings).where(bookings: {client_id: id})
# SELECT * FROM users INNER JOIN items ON items.owner_id = id INNER JOIN bookings ON items WHERE booking.client_id = x
# User.joins(items: [:bookings]).where(bookings: {client_id: id}).distinct
