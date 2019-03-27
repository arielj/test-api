class MoviesController < ApplicationController
  before_action :set_person
  before_action :load_movie, only: [:show]

  def index
    movies = get_scope.search(params[:q]).page(params[:page])
    render json: {movies: movies}
  end

  def show
    render json: @movie.to_json(add_people: params[:add_people].present?)
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
end
