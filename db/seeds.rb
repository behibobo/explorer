# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'    

User.destroy_all
Admin.destroy_all

Admin.create(username: "admin", password: "password")

provice = File.dirname(File.dirname(File.expand_path(__FILE__))) + '/db/province.csv'
city = File.dirname(File.dirname(File.expand_path(__FILE__))) + '/db/city.csv'

unless State.count > 0
    CSV.foreach(provice, :headers => false) do |row|
        State.create(
            id: row[0],
            name: row[1]
        )
    end
end

unless City.count > 0
    CSV.foreach(city, :headers => false) do |row|
        City.create(
            state_id: row[1],
            name: row[3]
        )
    end
end
shop = true

10.times do
    date = Date.today-rand(30)
    city = City.all.sample(1).first


    if shop
        shop = Shop.create(
            name: Faker::Name.name,
            address: Faker::Name.name,
            phone: Faker::PhoneNumber.cell_phone,
            city_id: city.id,
            state_id: city.state.id,
        )

        item = Item.create(
                shop_id: shop.id,
                name: Faker::Name.name,
                brand: Faker::Name.name,
                required_credit: [0,500,1000].sample
        )

        10.times do
            ItemCode.create(
                item: item
            )
        end
    else
        item = Item.create(
            name: Faker::Name.name,
            brand: Faker::Name.name,
        )
        10.times do
            ItemCode.create(
                item: item
            )
        end
    end
    shop = !shop
end

100.times do
    date = Faker::Date.between(from: 40.days.ago, to: Date.today)
    city = City.all.sample(1).first
    User.create(
        first_name: Faker::Name.name,
        last_name: Faker::Name.name,
        mobile: Faker::PhoneNumber.cell_phone,
        email: Faker::Internet.email,
        dob: Faker::Date.between(from: 40.years.ago, to: 15.years.ago),
        gender: [0,1].sample,
        city_id: city.id,
        state_id: city.state.id,
        created_at: date,
        updated_at: date
    )
end

