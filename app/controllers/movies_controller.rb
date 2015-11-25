class MoviesController < ApplicationController
  def index
    if params[:search]
      query = "%#{params[:search]}%"
      duration = "runtime_in_minutes #{params[:duration]}"
      @movies = Movie.where("title like ? or director like ?", query, query).where(duration)
      redirect_to movies_path, notice: "Search returned no results" if @movies.empty?
    else
      @movies = Movie.all
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image, :remote_poster_image_url, :description
    )
  end
end
