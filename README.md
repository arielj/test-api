# test-api
API REST

=========
# Endpoints

- GET /movies
Returns an array of movies as JSON

- GET /people
Returns an array of people as JSON

- GET /movies/1/people
Returns an array of people for movie with ID 1

- GET /people/1/movies
Returns an array of movies for person with ID 1

*Previous endpoints ending with /movies and /people supports a "page=integer" and a "q=string" querystring parameters for pagination and filtering (by title for movies, by name or lastname for people). Like "/movies?q=batman" or "/movies/1/people?q=actor_name" or "/people?page=3"*


- GET /movies/1
Returns movie with ID 1 as JSON

- GET /people/1
Returns person with ID 1 as JSON

- GET /movies/1/people/1
Returns person with ID 1 only if it's associated with movie with ID 1 as JSON

- GET /people/1/movie/1
Returns movie with ID 1 only if it's associated with person with ID 1 as JSON

*Previous endpoints ending with /:id supports an "add_movies=1" or "add_people=1" querystring parameters to control if the associations are only IDs (no param) or movie/person json objects (param present with value 1)*


- POST /people
Creates a new person

- POST /movies
Creates a new movie

- PUT /people/1
Updates person with ID 1

- PUT /movies/1
Updates movie with ID 1

*Previous endpoints require an authorizaton json web token, you can create an user at /admin/users and sent it's token as a request header with key "Authorization"*


=========
# Online app

- https://api-challenge-ariel.herokuapp.com/ (test endpoints)
- https://api-challenge-ariel.herokuapp.com/admin (configure data)


=========
# Frameworks/Libraries
- RubyOnRails
- trestle (admin panel, flexible admin panel solution)
- jwt (json web token management, most popular ruby gem)
- roman-numerals (decimal > roman conversion, no need to reinvent the wheel)
- kaminari (pagination, cleaner than will_paginate)
- slim (view template, clean and fast template engine)
