class Booking < ApplicationRecord
  belongs_to  :renter, class_name: 'User'

  has_one :item, dependent: :nullify
end
