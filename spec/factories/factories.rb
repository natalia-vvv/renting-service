# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { 'My item' }
    association :owner, factory: :user
    category { nil }
    daily_price { 20 }

    trait :with_category do
      category
    end
  end

  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    city
    account
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

  factory :item_option do
    item
    option
  end

  factory :filter do
    name { 'Color' }
  end

  factory :option do
    value { 'Red' }
    filter
  end

  factory :account do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    status { 'verified' }
  end
end
