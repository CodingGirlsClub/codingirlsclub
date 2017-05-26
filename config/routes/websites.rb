get  '/signup', to: 'users#new'
post '/signup', to: 'users#create'

get    '/login',  to: 'sessions#new'
post   '/login',  to: 'sessions#create'
delete '/logout', to: 'sessions#destroy'

resources :users, only: [:edit, :update]
resources :account_activations, only: [:edit]
resources :password_resets,     only: [:new, :create, :edit, :update]

resources :mentors
