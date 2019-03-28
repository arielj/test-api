var currentAuthToken;

document.addEventListener('turbolinks:load', function(){
  loginForm = document.getElementById('login_form');
  loginForm.addEventListener('ajax:beforeSend', function(e) {
    login = document.getElementById('login').value;
    password = document.getElementById('password').value;
    options = {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify({login: login, password: password})
    }

    document.querySelector('#current_auth_token span').innerText = 'None';
    currentAuthToken = null;

    fetch(loginForm.action, options).then(function(data){
      return data.json();
    }).then(function(myJson) {
      currentAuthToken = myJson.token;
      document.querySelector('#current_auth_token span').innerText = currentAuthToken;
    });
    e.preventDefault();
    return false;
  })
})
