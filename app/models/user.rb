class User < ApplicationRecord
  belongs_to :city

  has_many :items, foreign_key: :owner_id, inverse_of: 'owner'
  has_many :bookings, foreign_key: :client_id, inverse_of: 'renter'
  has_many :written_reviews, class_name: 'Review', foreign_key: :reviewer_id, inverse_of: 'reviewer'
  has_many :received_reviews, class_name: 'Review', as: :reviewable

  def get_reviews
    written_reviews
  end

  def get_booked_items
    bookings.map { |booking| booking.item }
  end
end
