# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :client, class_name: 'User'
  belongs_to :item
end
