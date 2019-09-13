class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:rate]
  before_action :authenticate_user!, except: [:show, :search]
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :rate]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :sanitize_params, only: [:create, :update]

  # GET /movies
  # GET /movies.json
  def index
    @movies = current_user.movies.page(params[:page]).per(Movie::PER_PAGE)
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = current_user.movies.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def search
    page = params[:page] || session[:page]
    categories = params[:categories] || session[:categories]
    ratings = params[:ratings] || session[:ratings]

    query = []
    query << "category IN (#{categories})" if categories.present?
    query << "avg_rating IN (#{ratings})" if ratings.present?

    @movies = if query.empty?
                params[:rendered_for] == "my_movies" ? current_user.movies : Movie.all
              else
                Movie.where(query.join(" AND ")) 
              end

    @movies = @movies.page(page).per(Movie::PER_PAGE)

    # session[:page] = page
    session[:categories] = categories
    session[:ratings] = ratings

    respond_to do |format|
      format.js
    end
  end

  def rate
    rating = @movie.user_ratings.where(user: current_user).first_or_initialize
    rating.rating = params[:rating]
    rating.save

    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def authorize_user!
      redirect_to root_url if @movie.user.id != current_user.id
    end

    def sanitize_params
      params[:movie][:category] = params[:movie][:category].to_i
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :description, :category, :image)
    end
end
