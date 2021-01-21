class Item < ApplicationRecord
  belongs_to :owner, class_name: 'User', dependent: :destroy

  has_many :booking, dependent: :nullify
  has_many :received_reviews, class_name: 'Review', as: :reviewable
end
