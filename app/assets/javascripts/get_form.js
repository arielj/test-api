document.addEventListener('turbolinks:load', function(){
  getForm = document.getElementById('url_form');
  getForm.addEventListener('ajax:beforeSend', function(e) {
    url = document.getElementById('url_field').value;
    fetch(url).then(function(data){
      return data.json();
    }).then(function(myJson) {
      document.getElementById('result').innerText = JSON.stringify(myJson, undefined, 2);
    });
    e.preventDefault();
    return false;
  })
})
