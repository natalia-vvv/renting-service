# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :owner, class_name: 'User', dependent: :destroy
  belongs_to :category, optional: true

  has_many :bookings, dependent: :nullify
  has_many :received_reviews, class_name: 'Review', as: :reviewable
  has_many :item_options
  has_many :options, through: :item_options

  validates :name, :owner_id, presence: true

  scope :by_name, ->(name) { where('name LIKE ?', "%#{name}%") }
  scope :by_category, lambda { |category_id|
    joins(:category).where(categories: { id: category_id })
  }
  scope :by_option, lambda { |*option_ids|
    joins(:item_options)
      .where(item_options: { option_id: [option_ids] })
      .group(:item_id)
      .having('COUNT(DISTINCT option_id) == ?', option_ids.count)
  }
end

#  Item.joins(:item_options).where(item_options: {option_id: [1, 2]}).group(:item_id).having('COUNT(DISTINCT option_id) == 2')
# SELECT * FROM items Where items.id IN (SELECT bookings.item_id From bookings)
# Item.where(id: Booking.select(:item_id).where(client_id: 1))
