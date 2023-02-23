# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'open-uri'
require 'json'

MY_API_KEY=""

Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

# Create 4 example movies
# 4.times do
#   Movie.create(
#     title: Faker::Movie.title,
#     overview: Faker::Lorem.paragraph(sentence_count: 2),
#     poster_url: Faker::Internet.url,
#     rating: rand(1..10).to_f.round(1)
#   )
# end

# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
# Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
# Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)


# Define the URL for the TMDB API endpoint
url = "http://tmdb.lewagon.com/movie/top_rated"

# Parse the JSON response from the API
response = JSON.parse(URI(url).read)

# Create fake movies using the data from the API
response['results'].each do |result|
  Movie.create(
    title: result['title'],
    overview: result['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{result['poster_path']}",
    rating: result['vote_average'].to_f.round(0)
  )
end
