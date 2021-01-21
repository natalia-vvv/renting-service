class Booking < ApplicationRecord
  belongs_to :client, class_name: 'User'
  belongs_to :item
end
