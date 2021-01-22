class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :reviewer, class_name: 'User'

  validate :is_review_actual

  private

  def is_review_actual
    if reviewable_type == 'Item'
      check_booked_item(reviewer.booked_items)
    elsif reviewable_type == 'User'
      check_reviewed_user(reviewer.owners_of_booked_items)
    end
  end

  def check_booked_item(items)
    items.include?(reviewable)
    errors.add(:reviewable, "user hasn't booked such item")
  end

  def check_reviewed_user(owners)
    owners.include?(reviewable) ? true : errors.add(:reviewable, "user hasn't dealt with such user")
  end
end
