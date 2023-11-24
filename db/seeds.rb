require 'faker'

puts "Cleaning database..."
Dog.destroy_all
User.destroy_all
puts "Cleaned"

5.times do
  user = User.create(
    email: Faker::Internet.email,
    password: "123456",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  puts "Created user: #{user.email}"
end

adr = ["rue de la Presse 17, Bruxelles", "30 Cleveland Way, London", "16 Villa Gaudelet, Paris"].sample

users = User.all
5.times do
  user = users.sample
  dog = Dog.create(
    name: Faker::Creature::Dog.name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    address: adr,
    user_id: user.id,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )

  # Attach a photo to the dog
  dog.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'Labradoodle.jpeg')), filename: 'Labradoodle.jpeg')

  puts "Created dog: #{dog.name} for user #{user.first_name}"
end
