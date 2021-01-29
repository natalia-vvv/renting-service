# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :reviewer, class_name: 'User'

  validate :review_actual?

  private

  def review_actual?
    case reviewable_type
    when 'Item'
      check_booked_item(reviewer.booked_items)
    when 'User'
      check_reviewed_user(reviewer.owners_of_booked_items)
    end
  end

  def check_booked_item(items)
    errors.add(:reviewable, "user hasn't booked such item") unless items.include?(reviewable)
  end

  def check_reviewed_user(owners)
    errors.add(:reviewable, "user hasn't dealt with such user") unless owners.include?(reviewable)
  end
end
