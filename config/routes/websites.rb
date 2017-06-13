get  '/signup', to: 'users#new'
post '/signup', to: 'users#create'

get    '/login',  to: 'sessions#new'
post   '/login',  to: 'sessions#create'
delete '/logout', to: 'sessions#destroy'

resources :account_activations, only: [:edit]
resources :password_resets,     only: [:new, :create, :edit, :update]

resources :ambassadors, only: [:index, :new, :create]

resources :mentors, only: [:index, :new, :create]

# 个人中心
namespace :settings do
  resource :profile, only: [:show, :update]
end

# 城市与学校 select2 搜索
resources :cities, only: [] do
  get :search, on: :collection
  get :search_universities, on: :member
end
