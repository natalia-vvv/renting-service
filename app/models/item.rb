class Item < ApplicationRecord
  belongs_to :owner, class_name: 'User', dependent: :destroy
  belongs_to :booking, optional: true

  has_many :received_reviews, class_name: 'Review', as: :reviewable

  validates :booking_id, presence: false
end
