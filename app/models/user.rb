class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :movies
  has_many :movie_ratings, class_name: "Rating"

  def is_publisher_of_movie?(movie)
  	id == movie.user_id
  end
end
