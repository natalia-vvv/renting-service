class Booking < ApplicationRecord
  belongs_to  :client, class_name: 'User'

  has_one :item, dependent: :nullify
end
