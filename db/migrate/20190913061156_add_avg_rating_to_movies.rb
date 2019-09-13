class AddAvgRatingToMovies < ActiveRecord::Migration[5.2]
  def change
  	add_column :movies, :avg_rating, :integer, limit: 1
  end
end
