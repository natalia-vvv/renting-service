# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :owner, class_name: 'User', dependent: :destroy
  belongs_to :category, optional: true

  has_many :bookings, dependent: :nullify
  has_many :received_reviews, class_name: 'Review', as: :reviewable

  validates :name, :owner_id, presence: true

  scope :by_name, ->(name) { where("name LIKE ?", '%' + name + '%') }
  scope :by_category, ->(category_id) {
    joins(:category).where(categories: { id: category_id })
  }
end

# SELECT * FROM items Where items.id IN (SELECT bookings.item_id From bookings)
# Item.where(id: Booking.select(:item_id).where(client_id: 1))
