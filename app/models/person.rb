class Person < ApplicationRecord
  serialize :aliases
  enum gender: [:male, :female]

  validates :first_name, :last_name, :gender, presence: true

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

  def aliases=(value)
    self[:aliases] = value.reject(&:blank?)
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



  def self.genders_for_select
    ds = I18n.t('person.genders')
    [[ds[0], :male], [ds[1], :female]]
  end
end
