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
      .group(:id)
      .having('COUNT(DISTINCT option_id) == ?', option_ids.count)
  }

  scope :by_price_range, lambda { |price_range, days|
    where((Item.arel_table[:daily_price] * days).between(price_range))
  }

  scope :by_non_booked_date, lambda { |start_date, end_date|
    bookings = Booking.arel_table
    # inner = joins(:bookings)
    #         .where.not(bookings[:start_date].between(date_range))
    #         .where.not(bookings[:end_date].between(date_range))

    # outer = left_joins(:bookings).where(bookings[:item_id].eq(nil))
    # ids = inner.pluck(:id) + outer.pluck(:id)
    # where(id: ids.uniq)

    rel = joins("LEFT JOIN bookings ON bookings.item_id = items.id AND bookings.start_date BETWEEN '#{start_date}' AND '#{end_date}'
          AND bookings.end_date BETWEEN '#{start_date}' AND '#{end_date}'")
          .where(bookings[:item_id].eq(nil))
    puts rel.to_sql
    rel
  }
end

# ) OR (bookings.item_id = items.id AND  '#{start_date}' BETWEEN bookings.start_date AND
#           bookings.end_date AND '#{end_date}' BETWEEN bookings.start_date AND bookings.end_date)

# SELECT * FROM items Where items.id IN (SELECT bookings.item_id From bookings)
# Item.where(id: Booking.select(:item_id).where(client_id: 1))

# SELECT * FROM items
# WHERE (daily_price * days) BETWEEN (min_price, max_price)
#
# WHERE start_date AND end_date BETWEEN (from, until)
