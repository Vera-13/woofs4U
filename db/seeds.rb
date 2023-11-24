require 'faker'
puts "Cleaning database..."
Dog.destroy_all
User.destroy_all
puts "cleaned"

# puts "Creating dogs..."
# # dishoom = {name: "Dishoom", address: "7 Boundary St, London E2 7JE", rating: 5}
# # pizza_east =  {name: "Pizza East", address: "56A Shoreditch High St, London E1 6PQ", rating: 4}

# # [dishoom, pizza_east].each do |attributes|
# #   restaurant = Restaurant.create!(attributes)
# #   puts "Created #{restaurant.name}"
# # end
# dog = Dog.create!(name: "Chocopuff", description: "Cute dog with a great personality and fluffy ears.", address: "Rue de la Presse 18 Bruxelles")
# puts dog.name
# puts "Finished!"

50.times do
  user = User.create(
    email: Faker::Internet.email,
    password: "123456",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  puts "Created user: #{user.email}"
end

users = User.all
50.times do
  user = users.sample
  dog = Dog.create(
    name: Faker::Creature::Dog.name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    address: Faker::Address.full_address,
    user_id: user.id,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )

  puts "Created dog: #{dog.name} for user #{user.first_name}"
end
