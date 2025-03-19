# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'
require 'json'
require 'faker'

# Seed Authors and Books using Faker
10.times do
  author = Author.create!(
    name: Faker::Book.author,
    bio: Faker::Lorem.paragraph(sentence_count: 3)
  )

  5.times do
    Book.create!(
      title: Faker::Book.title,
      description: Faker::Lorem.paragraph(sentence_count: 4),
      published_date: Faker::Date.backward(days: 365 * 5),
      author: author
    )
  end
end

# Seed Genres from a CSV file
csv_path = Rails.root.join('db', 'data', 'genres.csv')
CSV.foreach(csv_path, headers: true) do |row|
  Genre.create!(name: row['name'], description: row['description'])
end

# Seed Tags from a JSON file
json_path = Rails.root.join('db', 'data', 'tags.json')
tags = JSON.parse(File.read(json_path))
tags.each do |tag_data|
  Tag.create!(name: tag_data['name'])
end

# Associate Books with Genres and Tags (random associations)
Book.all.each do |book|
  genres = Genre.all.sample(rand(1..3))
  genres.each do |genre|
    BooksGenre.create!(book: book, genre: genre)
  end

  tags = Tag.all.sample(rand(1..4))
  tags.each do |tag|
    BooksTag.create!(book: book, tag: tag)
  end
end

puts "Seed complete! Total Authors: #{Author.count}, Books: #{Book.count}, Genres: #{Genre.count}, Tags: #{Tag.count}"
