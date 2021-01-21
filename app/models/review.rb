class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :reviewer, class_name: 'User'

  before_create :validate_review

  private

  def validate_review
    if reviewable_type == 'Item'
      reviewer.bookings.include? reviewable_id
    else
      true
    end
  end
end
