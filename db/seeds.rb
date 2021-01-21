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

Item.create(name: 'Luke item 1', owner_id: 1)
Item.create(name: 'Luke item 2', owner_id: 1)
Item.create(name: 'Harry item 1', owner_id: 2)
