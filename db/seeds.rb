# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
require 'open-uri'

# ======= Reset DB =======
puts "Clearing database..."
AlbumPhoto.destroy_all
Notification.destroy_all
Like.destroy_all
Follow.destroy_all
Photo.destroy_all
Album.destroy_all
User.destroy_all

# ======= Create Users =======
puts "Creating users..."
users = []
5.times do |i|
  users << User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "user#{i+1}@fotobook.com",
    password: "password",
    confirmed_at: Time.current,
    avatar: "https://picsum.photos/seed/photo#{i+1}/600/400"
  )
end

admin = User.create!(
  first_name: "Admin",
  last_name: "User",
  email: "admin@fotobook.com",
  password: "password",
  role: :admin,
  confirmed_at: Time.current
)
users << admin

# ======= Create Photos =======
puts "Creating photos..."
photos = []
100.times do
  photos << Photo.create!(
    user: users.sample,
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 2),
    image: "https://picsum.photos/seed/photo#{rand(1000)}/600/400",
    sharing_mode: %i[public_mode private_mode].sample
  )
end

# ======= Create Albums =======
puts "Creating albums..."
albums = []
20.times do
  album = Album.create!(
    user: users.sample,
    title: Faker::Lorem.sentence(word_count: 2),
    description: Faker::Lorem.paragraph(sentence_count: 1),
    sharing_mode: %i[public_mode private_mode].sample
  )

  sample_photos = photos.sample(rand(1..5))
  sample_photos.each do |photo|
    AlbumPhoto.create!(album: album, photo: photo)
  end

  albums << album
end

# ======= Create Follows =======
puts "Creating follows..."
100.times do
  follower = users.sample
  following = users.sample

  # Tránh self-follow và trùng follow
  next if follower == following
  next if Follow.exists?(follower: follower, following: following)

  Follow.create!(follower: follower, following: following)
end

# ======= Create Likes =======
puts "Creating likes..."
100.times do
  user = users.sample
  likeable = (photos + albums).sample
  Like.find_or_create_by!(user: user, likeable: likeable)
end

# ======= Create Notifications =======
puts "Creating notifications..."
20.times do
  user = users.sample
  notifier = (users - [ user ]).sample
  notifiable = (photos + albums).sample
  Notification.create!(
    user: user,
    notifier: notifier,
    notifiable: notifiable,
    action: "liked"
  )
end

puts "🌱 Done seeding database!"
