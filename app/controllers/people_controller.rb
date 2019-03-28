class PeopleController < ApplicationController
  before_action :authorize, only: [:update, :create]
  before_action :set_movie
  before_action :load_person, only: [:show, :update]

  def index
    people = get_scope.search(params[:q]).page(params[:page])
    render json: {movies: people}.to_json
  end

  def show
    render json: @person.to_json(add_movies: params[:add_movies].present?)
  end

  def update
    @person.update_attributes(person_update_params)
    if @person.errors.any?
      render json: {errors: @person.errors.full_messages}
    else
      render json: @person.to_json
    end
  rescue ActionController::ParameterMissing => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  def create
    person = Person.create(person_create_params) #create with no movies
    if person.errors.any?
      render json: {errors: person.errors.full_messages}
    else
      person.update_attributes(person_update_params) #set movies if any
      render json: person.to_json
    end
  rescue ActionController::ParameterMissing => e
    render json: {message: e.message}, status: :unprocessable_entity
    return false
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

  def person_update_params
    params.require(:person).permit(:first_name, :last_name, :aliases, :movies_as_actor_ids, :movies_as_director_ids, :movies_as_producer_ids)
  end

  def person_create_params
    params.require(:person).permit(:first_name, :last_name, :aliases)
  end
end
