# frozen_string_literal: true

City.create(
  [{ name: 'Lviv' },
   { name: 'Kyiv' },
   { name: 'Rivne' },
   { name: 'Bukovel' },
   { name: 'Yaremche' }]
)

User.create(
  [{ first_name: 'Luke', last_name: 'Skywalker', city_id: 1 },
   { first_name: 'Harry', last_name: 'Potter', city_id: 1 },
   { first_name: 'Natalia', last_name: 'Veselska', city_id: 3 },
   { first_name: 'Name', last_name: 'Surname', city_id: 3 }]
)

Item.create(
  [{ name: 'Luke item 1', owner_id: 1, category_id: 1 },
   { name: 'Luke item 2', owner_id: 1, category_id: 1 },
   { name: 'Harry item 1', owner_id: 2, category_id: 1 },
   { name: 'Harry item 2', owner_id: 2 },
   { name: 'My item 1', owner_id: 3 },
   { name: 'My item 2', owner_id: 3, category_id: 3 },
   { name: 'Someones item 1', owner_id: 4, category_id: 3 }]
)

Booking.create(
  [{ start_date: '02-02-2020', end_date: '03-03-2020', client_id: 1,
     item_id: 3 },
   { start_date: '02-02-2020', end_date: '03-03-2020', client_id: 1,
     item_id: 4 },
   { start_date: '02-02-2020', end_date: '03-03-2020', client_id: 1,
     item_id: 5 },
   { start_date: '02-02-2020', end_date: '03-03-2020', client_id: 3,
     item_id: 1 },
   { start_date: '02-02-2020', end_date: '03-03-2020', client_id: 3,
     item_id: 2 }]
)

Review.create(
  [{ message: 'nice item!', reviewer_id: 1, reviewable_type: 'Item',
     reviewable_id: 3 },
   { message: 'not really nice item!', reviewer_id: 1,
     reviewable_type: 'Item', reviewable_id: 4 },
   { message: 'good guy!', reviewer_id: 1, reviewable_type: 'User',
     reviewable_id: 3 },
   { message: 'not good guy!', reviewer_id: 1, reviewable_type: 'User',
     reviewable_id: 2 },
   { message: 'not good guy!', reviewer_id: 1, reviewable_type: 'User',
     reviewable_id: 4 }]
)

Category.create([{ name: 'Clothes' }, { name: 'Boots' }, { name: 'Tools' }])

Filter.create(
  [{ name: 'Color', category_id: 1 },
   { name: 'Type', category_id: 1 },
   { name: 'Size', category_id: 2 },
   { name: 'Brand', category_id: 2 }]
)

Option.create(
  [{ value: 'Red', filter_id: 1 },
   { value: 'Green', filter_id: 1 },
   { value: 'Blue', filter_id: 1 },
   { value: 'Coat', filter_id: 2 },
   { value: 'Jacket', filter_id: 2 },
   { value: 'Small', filter_id: 3 },
   { value: 'Medium', filter_id: 3 },
   { value: 'Big', filter_id: 3 }]
)

ItemOption.create(
  [{ item_id: 1, option_id: 1 },
   { item_id: 1, option_id: 2 },
   { item_id: 2, option_id: 1 },
   { item_id: 3, option_id: 3 },
   { item_id: 4, option_id: 3 },
   { item_id: 4, option_id: 1 }]
)
# Option.all.each_with_index do |option, i|
#   i = Item.create({ name: "Optioned item #{i+1}", owner_id: rand(1..4) })
#   i.options << option
# end
