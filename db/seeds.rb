# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
    email: "test@example.come",
    name: "john_example",
    password: "aaaaaa"
 )

# Label.create!(name: 'プライベート')
# Label.create!(name: '仕事')
# Label.create!(name: '家族')
