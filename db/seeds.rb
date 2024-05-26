# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Define the number of posts and reviews you want to create
NUM_POSTS = 50000
NUM_REVIEWS = 20000

# Create users
users = []
100.times do |n|
  users << User.create(username: "user#{n + 1}")
end

# Create posts
posts = []
NUM_POSTS.times do |n|
  user = users.sample
  posts << Post.create(
    title: "Post #{n + 1}",
    body: "This is the body of post #{n + 1}",
    user_id: user.id
  )
end

# Create reviews
NUM_REVIEWS.times do
  post = posts.sample
  user = users.sample
  Review.create(
    rating: rand(1..5),
    comment: "This is a review for post #{post.id}",
    user_id: user.id,
    post_id: post.id
  )
end
