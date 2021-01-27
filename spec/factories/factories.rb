# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { 'My item' }
    association :owner, factory: :user
    category { nil }

    trait :with_category do
      category
    end
  end

  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    city
  end

  factory :booking do
    start_date { '02-02-2020' }
    end_date { '03-03-2020' }
    association :client, factory: :user
    item
  end

  factory :city do
    name { 'Lviv' }
  end

  factory :category do
    name { 'Sport' }
  end
end
