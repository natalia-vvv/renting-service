# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { 'My item' }
    association :owner, factory: :user
    category { nil }

    trait :with_category do
      category_id { 1 }
    end
  end
end

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    city
  end
end

FactoryBot.define do
  factory :booking do
    start_date { '02-02-2020' }
    end_date { '03-03-2020' }
    client_id { 1 }
    item
  end
end

FactoryBot.define do
  factory :city do
    name { 'Lviv' }
  end
end

FactoryBot.define do
  factory :category do
    name { "Sport" }
  end
end
