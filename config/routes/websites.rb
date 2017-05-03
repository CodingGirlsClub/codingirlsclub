resources :sessions

resources :users do
  member do
    get :identity_selector
    patch :identity_selector
  end
  collection do
    get :access_invite_code, :access_campus_ambassador, :reset_password, :forget_password
    post :access_invite_code, :access_campus_ambassador, :reset_password, :forget_password
  end

end

resources :mentors

get '/signup', to: 'users#new'

get  '/login', to: 'sessions#new'
post '/login', to: 'sessions#create'

get  '/token_login', to: 'sessions#token_login'
post '/token_login', to: 'sessions#token_login'

delete '/logout', to: 'sessions#destroy'
