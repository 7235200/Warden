# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(id: 1,
    name:  "Foo",
    balance: 85000,
    email: "foo@bar.com",
    password:              "foobar",
    password_confirmation: "foobar")

['Internet', 'Phone', 'Apartment', 'Food', 'Car'].each do |n|
  user_id = 1
  name = n
  isRequire = true
  Kind.create!(user_id: user_id,
  name:  name,
  isRequire: isRequire)
end

['Games', 'Parties', 'Shopping', 'Gifts', 'Girlfriend', 'Boarding', 'Other'].each do |n|
  user_id = 1
  name = n
  isRequire = false
  Kind.create!(user_id: user_id,
  name:  name,
  isRequire: isRequire)
end

Purpose.create!(user_id: 1,
    name:  "Ipad air",
    money: 40000,
    storage: 12000)
Purpose.create!(user_id: 1,
    name:  "Fender Telecaster",
    money: 35000,
    storage: 5000)
Purpose.create!(user_id: 1,
    name:  "Pedalboard",
    money: 2000,
    storage: 2000)
Purpose.create!(user_id: 1,
    name:  "Playstation 4",
    money: 21000,
    storage: 8000)

arr = ['Internet', 'Phone', 'Apartment', 'Food', 'Car', 'Games', 'Parties', 'Shopping', 'Gifts', 'Girlfriend', 'Boarding', 'Other']
30.times do |n|
  user_id = 1
  kind_name = arr.sample
  kind_id = Faker::Number.between(from = 1, to = 12)
  name = Faker::Commerce.product_name
  price = Faker::Number.between(from = 1500, to = 40000)
  created_at = Faker::Date.between(3.month.ago, Date.today)

  Transaction.create!(user_id: user_id,
      kind_id: kind_id,
      kind_name: kind_name,
      name:  name,
      price: price,
      created_at: created_at)
end