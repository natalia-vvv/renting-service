FactoryBot.define do
  factory :item do
    name { "Item" }
    association :owner, factory: :user
  end
end
