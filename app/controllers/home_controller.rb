class HomeController < ApplicationController

  def index
  	@movies = Movie.all.page(params[:page]).per(Movie::PER_PAGE)
  	@category_facet = Hash[Movie.group(:category).count.sort_by{|k, v| v}.reverse]
  	@rating_facet = Hash[Movie.where.not(avg_rating: nil).group(:avg_rating).count.sort_by{|k, v| v}.reverse]
  end

end
