class User < ApplicationRecord
  has_many :item
  belongs_to :city
end
