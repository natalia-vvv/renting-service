class Item < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
