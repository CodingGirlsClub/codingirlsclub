Cgc::Engine.routes.draw do
  root to: 'dashboards#index'

  get    '/login',  to: 'sessions#new', as: 'login'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:index, :show] do
    put :do_approve_success, :do_approve_failed, on: :member
  end

  # 城市与学校 select2 搜索
  resources :cities, only: [] do
    get :search, on: :collection
    get :search_universities, on: :member
  end
end
