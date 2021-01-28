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
  scope :by_category, ->(category_id) do
    where(category_id: category_id )
  end

  scope :by_option, ->(option_ids) do
    joins(:item_options)
      .where(item_options: { option_id: option_ids })
      .group(:item_id)
      .having('COUNT(DISTINCT option_id) == ?', option_ids.count)
  end

  scope :by_price_range, ->(min_price, max_price, days) do

  end
end

# Item.joins(:item_options).where(item_options: {option_id: [1, 2]}).group(:item_id).having('COUNT(DISTINCT option_id) == 2')
# SELECT * FROM items Where items.id IN (SELECT bookings.item_id From bookings)
# Item.where(id: Booking.select(:item_id).where(client_id: 1))

# SELECT * FROM items WHERE (daily_price * days) BETWEEN (min_price, max_price)
