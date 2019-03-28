class Movie < ApplicationRecord
  validates :title, :release_year, presence: true

  has_many :movie_people
  has_many :people, through: :movie_people

  [:actor, :director, :producer].each do |role|
    has_many "movie_people_as_#{role}".to_sym, -> { where(role: role) }, class_name: 'MoviePerson'
    has_many role.to_s.pluralize.to_sym, through: "movie_people_as_#{role}", class_name: 'Person', source: :person
  end

  scope :search, -> (q) { q ? where('title LIKE ?', "%#{q}%") : self }

  def actors_ids=(values)
    values = split_values(values)
    self.actors = Person.where(id: values)
  end

  def directors_ids=(values)
    values = split_values(values)
    self.directors = Person.where(id: values)
  end

  def producers_ids=(values)
    values = split_values(values)
    self.producers = Person.where(id: values)
  end


  def as_json(options={})
    to_merge = if options[:add_people]
      { actors: actors, directors: directors, producers: producers }
    else
      { actor_ids: actors.pluck(:id), director_ids: directors.pluck(:id),
        producer_ids: producers.pluck(:id) }
    end

    to_merge[:roman_release_year] = RomanNumerals.to_roman(release_year)

    super.merge(to_merge)
  end

private
  def split_values(values)
    values.is_a?(String) ? values.split(',').map(&:strip) : values
  end
end
