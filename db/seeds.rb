# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.destroy_all
Product.destroy_all

Color.destroy_all
Size.destroy_all
Category.destroy_all
State.destroy_all

["Black", "Blue", "White", "Grey"].map do |c|
  Color.create(name: c)
end

["Small", "Medium", "Large", "XL"].map do |s|
  Size.create(code: s)
end

["Hoodie", "Tee", "Crewneck", "Hat"].map do |c|
  Category.create(name: c)
end

["New", "On Sale", "Sold Out"].map do |s|
  State.create(name: s)
end

if Rails.env.development?
  AdminUser.create!(email: "admin@unifiedapparel.ca", password: "password", password_confirmation: "password")
end

["Unified Classic Hoodie", "Unified Exclusive Hoodie I", "Unified Exclusive Hoodie II", "Unified Winter Exclusive Hoodie"].map do |h|
  Product.create(name:        h,
                 stock:       50,
                 description: h + " now available!",
                 category:    Category.where("name = ?", "Hoodie").first,
                 state:       State.where("name = ?", "New").first)
end
["Unified Classic Tee", "Unified Inspired Tee", "Unified Winter Exclusive Tee"].map do |t|
  Product.create(name:        t,
                 stock:       40,
                 description: t + " now available!",
                 category:    Category.where("name = ?", "Tee").first,
                 state:       State.where("name = ?", "New").first)
end
["Unified Classic Crewneck", "Unified Winter Exclusive Crewneck"].map do |c|
  Product.create(name:        c,
                 stock:       20,
                 description: c + " now available!",
                 category:    Category.where("name = ?", "Crewneck").first,
                 state:       State.where("name = ?", "New").first)
end
Product.create( name: "Unified Classic Hat",
                stock:       20,
                description: "Unified Classic Hat now available!",
                category:    Category.where("name = ?", "Hat").first,
                state:       State.where("name = ?", "New").first)
