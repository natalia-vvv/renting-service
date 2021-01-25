# frozen_string_literal: true

class City < ApplicationRecord
  has_many :users
  has_many :items, through: :users
end
