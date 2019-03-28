document.addEventListener('turbolinks:load', function(){
  movieForm = byId('movie_form');
  movieForm.addEventListener('ajax:beforeSend', function(e) {
    e.preventDefault();
    movieTitle = byId('title').value.trim();
    movieReleaseYear = byId('release_year').value.trim();
    movieActorsIds = byId('actors').value.trim();
    movieDirectorsIds = byId('directors').value.trim();
    movieProducersIds = byId('producers').value.trim();
    movieAttrs = {};
    if (movieTitle != '') movieAttrs.title = movieTitle;
    if (movieReleaseYear != '') movieAttrs.release_year = movieReleaseYear;
    if (movieActorsIds != '') movieAttrs.actors_ids = movieActorsIds;
    if (movieDirectorsIds != '') movieAttrs.directors_ids = movieDirectorsIds;
    if (movieProducersIds != '') movieAttrs.producers_ids = movieProducersIds;

    options = {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify({movie: movieAttrs})
    }

    if (currentAuthToken) options.headers['Authorization'] = currentAuthToken;

    url = byId('movie_url_field').value;
    if (url != '/movies') options.method = 'PUT';

    fetch(url, options).then(function(data){
      return data.json();
    }).then(function(myJson) {
      byId('movie_result').innerText = JSON.stringify(myJson, undefined, 2);
    });
    return false;
  })
})
