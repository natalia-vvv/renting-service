class Option < ApplicationRecord
  has_and_belongs_to_many :items
  belongs_to :filter
end
