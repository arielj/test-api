class MoviesController < ApplicationController
  before_action :authorize, only: [:update, :create]
  before_action :set_person
  before_action :load_movie, only: [:show, :update]

  def index
    movies = get_scope.search(params[:q]).page(params[:page])
    render json: {movies: movies}
  end

  def show
    render json: @movie.to_json(add_people: params[:add_people].present?)
  end

  def update
    @movie.update_attributes(movie_params)
    if @movie.errors.any?
      render json: {errors: @movie.errors.full_messages}
    else
      render json: @movie.to_json
    end
  rescue ActionController::ParameterMissing => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  def create
    movie = Movie.create(movie_params)
    if movie.errors.any?
      render json: {errors: movie.errors.full_messages}
    else
      render json: movie.to_json
    end
  rescue ActionController::ParameterMissing => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

private
  def set_person
    @person = Person.find(params[:person_id]) if params[:person_id]
  end

  def load_movie
    @movie = get_scope.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: {message: e.message}, status: :not_found
  end

  def get_scope
    @person ? @person.movies : Movie
  end

  def movie_params
    params.require(:movie).permit(:title, :release_year, :actors_ids, :directors_ids, :producers_ids)
  end
end
