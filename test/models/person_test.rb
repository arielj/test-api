require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'movies relationships' do
    @person1 = Person.create(first_name: 'Robert', last_name: 'Downey Jr.', aliases: ['IronMan','Sherlock'], gender: :male)
    @person2 = Person.create(first_name: 'Ben', last_name: 'Affleck', aliases: ['Batman'], gender: :male)

    @movie1 = Movie.create(title: 'IronMan', release_year: '2008')
    @movie2 = Movie.create(title: 'B vs S', release_year: '2015')

    @movie1.movie_people_as_actor.create(person: @person1)
    @movie2.movie_people_as_actor.create(person: @person2)
    @movie2.movie_people_as_director.create(person: @person2)

    assert_includes @person1.movies_as_actor, @movie1
    assert_not_includes @person1.movies_as_actor, @movie2
    assert_empty @person1.movies_as_director
    assert_empty @person1.movies_as_producer

    assert_includes @person2.movies_as_actor, @movie2
    assert_not_includes @person2.movies_as_actor, @movie1
    assert_includes @person2.movies_as_director, @movie2
    assert_not_includes @person2.movies_as_director, @movie1
    assert_empty @person1.movies_as_producer
  end
end
