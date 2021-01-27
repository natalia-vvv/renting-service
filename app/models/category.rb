# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :items
  has_many :filters

  validates :name, uniqueness: true
end
