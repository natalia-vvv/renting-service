# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :owner, class_name: 'User', dependent: :destroy

  has_many :bookings, dependent: :nullify
  has_many :received_reviews, class_name: 'Review', as: :reviewable
end

# SELECT * FROM items Where items.id IN (SELECT bookings.item_id From bookings)
# Item.where(id: Booking.select(:item_id).where(client_id: 1))
