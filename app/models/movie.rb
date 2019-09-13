class Movie < ApplicationRecord
	CATEGORIES = ["Action", "Drama", "Suspense", "Sci-Fi", "Thriller", "Romance", "Animation"]
	MIN_STARS = 1
	MAX_STARS = 5
	PER_PAGE = 10

	enum category: CATEGORIES 
  belongs_to :user
  has_many :user_ratings, class_name: "Rating", dependent: :destroy

  has_attached_file :image, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def rating_by_user(_user)
  	user_ratings.where(user: _user).first.try(:rating).to_i
  end
end
