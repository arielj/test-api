class MoviePerson < ApplicationRecord
  self.table_name = 'movies_people'

  belongs_to :movie
  belongs_to :person

  enum role: [:actor, :director, :producer]

  validates :movie_id, :person_id, :role, presence: true
  validates :movie_id, uniqueness: {scope: [:person_id, :role]}
end
