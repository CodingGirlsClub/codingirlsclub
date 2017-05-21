get  '/signup', to: 'users#new'
post '/signup', to: 'users#create'

get    '/login',  to: 'sessions#new'
post   '/login',  to: 'sessions#create'
delete '/logout', to: 'sessions#destroy'

resources :users, only: [:edit, :update] do
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
