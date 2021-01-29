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

  scope :by_price_range, ->(price_range, days) do
    where((Item.arel_table[:daily_price] * days).between(price_range))
  end

  scope :by_non_booked_date, ->(from_date, until_date) do
    bookings = Booking.arel_table

    inner = joins(:bookings)
      .where.not(bookings[:start_date].between(from_date..until_date))
      .where.not(bookings[:end_date].between(from_date..until_date))

    outer = left_outer_joins(:bookings).where(bookings[:item_id].eq(nil))
    inner + outer
  end
end

# SELECT * FROM items Where items.id IN (SELECT bookings.item_id From bookings)
# Item.where(id: Booking.select(:item_id).where(client_id: 1))

# SELECT * FROM items
# WHERE (daily_price * days) BETWEEN (min_price, max_price)
#
# WHERE start_date AND end_date BETWEEN (from, until)
