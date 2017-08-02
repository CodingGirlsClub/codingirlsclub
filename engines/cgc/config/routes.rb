Cgc::Engine.routes.draw do
  root to: 'dashboards#index'

  get    '/login',  to: 'sessions#new', as: 'login'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:index, :show] do
    put :do_approve_success, :do_approve_failed, on: :member
  end

  # 助教
  resources :mentors, only: [:index, :show] do
    put :do_status_success, :do_status_failed, on: :member
  end

  # 校园大使
  resources :ambassadors, only: [:index, :show] do
    put :do_status_success, :do_status_failed, on: :member
  end

  resources :qas, only: [:index, :show, :new, :create, :edit, :update] do
    put :do_status_disabled, :do_status_enabled, on: :member
    resources :questions, only: [:index, :create, :destroy]
  end

  # 邀请码
  resources :referrals, only: [:index, :create]

  # 城市与学校 select2 搜索
  resources :cities, only: [] do
    get :search, on: :collection
    get :search_universities, on: :member
  end
end
