cities = City.create(
  [{ name: 'Lviv' },
   { name: 'Kyiv' },
   { name: 'Rivne' },
   { name: 'Bukovel' },
   { name: 'Yaremche' }])

users = User.create(
  [{ first_name: 'Luke', last_name: 'Skywalker', city_id: 1 },
   { first_name: 'Harry', last_name: 'Potter', city_id: 1 },
   { first_name: 'Natalia', last_name: 'Veselska', city_id: 3 },
   { first_name: 'Name', last_name: 'Surname', city_id: 3 }])

items = Item.create(
  [{ name: 'Luke item 1', owner_id: 1 },
   { name: 'Luke item 2', owner_id: 1 },
   { name: 'Harry item 1', owner_id: 2 },
   { name: 'Harry item 2', owner_id: 2 },
   { name: 'My item 1', owner_id: 3 },
   { name: 'My item 2', owner_id: 3 },
   { name: 'Someones item 1', owner_id: 4 }])

bookings = Booking.create(
  [{ start_date: '02-02-2020', end_date: '03-03-2020', client_id: 1, item_id: 3 },
   { start_date: '02-02-2020', end_date: '03-03-2020', client_id: 1, item_id: 4 },
   { start_date: '02-02-2020', end_date: '03-03-2020', client_id: 1, item_id: 5 },
   { start_date: '02-02-2020', end_date: '03-03-2020', client_id: 3, item_id: 1 },
   { start_date: '02-02-2020', end_date: '03-03-2020', client_id: 3, item_id: 2 }])

reviews = Review.create(
  [{message: 'nice item!', reviewer_id: 1, reviewable_type: 'Item', reviewable_id: 3},
   { message: 'not really nice item!', reviewer_id: 1, reviewable_type: 'Item', reviewable_id: 4},
   { message: 'good guy!', reviewer_id: 1, reviewable_type: 'User', reviewable_id: 3},
   { message: 'not good guy!', reviewer_id: 1, reviewable_type: 'User', reviewable_id: 2},
   { message: 'not good guy!', reviewer_id: 1, reviewable_type: 'User', reviewable_id: 4}])
