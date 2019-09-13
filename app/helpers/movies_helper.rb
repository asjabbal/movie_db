module MoviesHelper
	def category_options
		Movie::CATEGORIES.map.with_index{ |category, index| [category, index] }
	end
end
