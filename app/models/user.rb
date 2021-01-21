class User < ApplicationRecord
  belongs_to :city

  has_many :items, inverse_of: 'owner'
  has_many :bookings, inverse_of: 'renter'
  has_many :written_reviews, class_name: 'Review', inverse_of: 'reviewer'
  has_many :received_reviews, class_name: 'Review', as: :reviewable
end
