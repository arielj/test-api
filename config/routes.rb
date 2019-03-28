Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :movies do
    resources :people
  end

  resources :people do
    resources :movies
  end

  post :auth, to: 'authentication#auth'

  root to: 'index#index'

end
