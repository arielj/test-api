class Person < ApplicationRecord
  serialize :aliases

  validates :first_name, :last_name, presence: true

  has_many :movie_people
  has_many :movies, through: :movie_people

  [:actor, :director, :producer].each do |role|
    has_many "movie_people_as_#{role}".to_sym, -> { where(role: role) }, class_name: 'MoviePerson'
    has_many "movies_as_#{role}".to_sym, through: "movie_people_as_#{role}", class_name: 'Movie', source: :movie
  end

  scope :search, -> (q) { q ? where('first_name LIKE :q OR last_name LIKE :q', {q: "%#{q}%"}) : self }

  def aliases
    self[:aliases] ||= []
  end

  def aliases=(values)
    values = split_values(values)
    self[:aliases] = values.reject(&:blank?)
  end

  def movies_as_actor_ids=(values)
    values = split_values(values)
    self.movies_as_actor = Movie.where(id: values)
  end

  def movies_as_director_ids=(values)
    values = split_values(values)
    self.movies_as_director = Movie.where(id: values)
  end

  def movies_as_producer_ids=(values)
    values = split_values(values)
    self.movies_as_producer = Movie.where(id: values)
  end

  def to_label
    "#{first_name} #{last_name}"
  end

  def as_json(options={})
    to_merge = if options[:add_movies]
      { movies_as_actor: movies_as_actor, movies_as_director: movies_as_director,
        movies_as_producer: movies_as_producer }
    else
      { movies_as_actor_ids: movies_as_actor.pluck(:id),
        movies_as_director_ids: movies_as_director.pluck(:id),
        movies_as_producer_ids: movies_as_producer.pluck(:id) }
    end

    super.merge(to_merge)
  end

private
  def split_values(values)
    values.is_a?(String) ? values.split(',').map(&:strip) : values
  end
end
