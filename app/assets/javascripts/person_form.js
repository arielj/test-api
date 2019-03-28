document.addEventListener('turbolinks:load', function(){
  personForm = byId('person_form');
  personForm.addEventListener('ajax:beforeSend', function(e) {
    e.preventDefault();
    personFirstName = byId('first_name').value.trim();
    personLastName = byId('last_name').value.trim();
    personAliases = byId('aliases').value.trim();
    personMoviesAsActorIds = byId('movies_as_actor').value.trim();
    personMoviesAsDirectorIds = byId('movies_as_director').value.trim();
    personMoviesAsProducerIds = byId('movies_as_producer').value.trim();

    personAttrs = {};
    if (personFirstName != '') personAttrs.first_name = personFirstName;
    if (personLastName != '') personAttrs.last_name = personLastName;
    if (personAliases != '') personAttrs.aliases = personAliases;
    if (personMoviesAsActorIds != '') personAttrs.movies_as_actor_ids = personMoviesAsActorIds;
    if (personMoviesAsDirectorIds != '') personAttrs.movies_as_director_ids = personMoviesAsDirectorIds;
    if (personMoviesAsProducerIds != '') personAttrs.movies_as_producer_ids = personMoviesAsProducerIds;

    options = {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify({person: personAttrs})
    }
    if (currentAuthToken) options.headers['Authorization'] = currentAuthToken;


    url = byId('person_url_field').value;
    if (url != '/people') options.method = 'PUT';

    fetch(url, options).then(function(data){
      return data.json();
    }).then(function(myJson) {
      byId('person_result').innerText = JSON.stringify(myJson, undefined, 2);
    });
    return false;
  })
})
