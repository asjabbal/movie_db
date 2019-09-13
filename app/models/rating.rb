class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  after_save :update_movie_avg_rating

  private

  def update_movie_avg_rating
  	movie.update_attribute(:avg_rating, movie.user_ratings.average(:rating).to_i)
  end
end
