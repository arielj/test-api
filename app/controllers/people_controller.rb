class PeopleController < ApplicationController
  before_action :set_movie
  before_action :load_person, only: [:show]

  def index
    people = get_scope.search(params[:q]).page(params[:page])
    render json: {movies: people}.to_json
  end

  def show
    render json: @person.to_json(add_movies: params[:add_movies].present?)
  end

private
  def set_movie
    @movie = Movie.find(params[:movie_id]) if params[:movie_id]
  end

  def load_person
    @person = get_scope.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: {message: e.message}, status: :not_found
  end

  def get_scope
    @movie ? @movie.people : Person
  end
end
