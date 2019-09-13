# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

t = Time.now

for i in 1..100 do
	user = User.new
	user.name = "User#{i}"
	user.email = "user#{i}@moviedb.com"
	user.password = "12345678"
	user.password_confirmation = "12345678"
	user.save

	for j in 1..10 do
		movie = user.movies.new
		movie.title = "Movie#{j}_#{i}"
		movie.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut luctus, augue at vulputate condimentum, sem lacus suscipit dolor, eu ultricies tortor mauris eget mi. Vestibulum suscipit nunc ut porta volutpat. Vestibulum at tincidunt nibh, et rutrum dui. Duis viverra enim dapibus, interdum lorem dapibus, mollis leo. Nullam at placerat sapien."
		movie.image = File.new(Rails.root.join("app", "assets", "images", "default_movie_img.png"))
		movie.category = rand(0..Movie::CATEGORIES.length-1)
		movie.save
	end

end

User.all.each{|user|
	movies = Movie.all.sample(rand(10..50))

	movies.each{|movie|
		Rating.create(user: user, movie: movie, rating: rand(Movie::MIN_STARS..Movie::MAX_STARS))
	}
}

puts "Total time took to seed data >> #{Time.now - t}"