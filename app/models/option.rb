# frozen_string_literal: true

class Option < ApplicationRecord
  has_many :item_options
  has_many :items, through: :item_options

  belongs_to :filter
end
