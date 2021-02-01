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
    where(category_id: category_id)
  }

  scope :by_option, lambda { |option_ids|
    joins(:item_options)
      .where(item_options: { option_id: option_ids })
      .group(:item_id)
      .having('COUNT(DISTINCT option_id) == ?', option_ids.count)
  }

  scope :by_price_range, lambda { |price_range, days|
    where((Item.arel_table[:daily_price] * days).between(price_range))
  }

  scope :by_non_booked_date, lambda { |from_date, until_date|
    bookings = Booking.arel_table

    inner = joins(:bookings)
            .where.not(bookings[:start_date].between(from_date..until_date))
            .where.not(bookings[:end_date].between(from_date..until_date))

    outer = left_outer_joins(:bookings).where(bookings[:item_id].eq(nil))
    ids = inner.pluck(:id) + outer.pluck(:id)
    Item.where(id: ids.uniq)
  }
end

# SELECT * FROM items Where items.id IN (SELECT bookings.item_id From bookings)
# Item.where(id: Booking.select(:item_id).where(client_id: 1))

# SELECT * FROM items
# WHERE (daily_price * days) BETWEEN (min_price, max_price)
#
# WHERE start_date AND end_date BETWEEN (from, until)
