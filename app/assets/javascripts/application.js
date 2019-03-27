// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks

document.addEventListener('turbolinks:load', function(){
  form = document.getElementById('url_form');
  form.addEventListener('ajax:beforeSend', function(e) {
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
