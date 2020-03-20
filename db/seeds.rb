# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'    

User.destroy_all
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

100.times do
    User.create(
        first_name: Faker::Name.name,
        last_name: Faker::Name.name,
        mobile: Faker::PhoneNumber.cell_phone,
        password: "password",
        city_id: City.all.sample(1).first.id
    )
end

