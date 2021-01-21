# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
City.create(name: 'Lviv')
City.create(name: 'Kyiv')
City.create(name: 'Rivne')
City.create(name: 'Bukovel')
City.create(name: 'Yaremche')

User.create(first_name: 'Luke', last_name: 'Skywalker', city_id: 1)
User.create(first_name: 'Harry', last_name: 'Potter', city_id: 1)
User.create(first_name: 'Natalia', last_name: 'Veselska', city_id: 3)
User.create(first_name: 'Name', last_name: 'Surname', city_id: 3)

Item.create(name: 'Luke item 1', owner_id: 1)
Item.create(name: 'Luke item 2', owner_id: 1)
Item.create(name: 'Harry item 1', owner_id: 2)
Item.create(name: 'My item 1', owner_id: 3)
Item.create(name: 'My item 2', owner_id: 3)
Item.create(name: 'Someone item 1', owner_id: 4)

Booking.create(start_date: '02-02-2020', end_date: '03-03-2020', client_id: 1)
Booking.create(start_date: '02-02-2020', end_date: '03-03-2020', client_id: 1)
Booking.create(start_date: '02-02-2020', end_date: '03-03-2020', client_id: 1)

# Review.create(message: 'nice item!', reviewer_id: 1, reviewable_type: 'Item', reviewable_id: 3)
