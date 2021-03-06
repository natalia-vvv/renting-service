# frozen_string_literal: true

class Filter < ApplicationRecord
  has_many :options

  belongs_to :category, optional: true
end
