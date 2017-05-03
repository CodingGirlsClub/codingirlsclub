namespace :admin do

  root 'dashboards#index'
  resources :admins
  resources :sessions
  resources :users do
    collection do
      get :casting_check, :latent_user_list, :general_tokens, :gen_general_token
    end
    member do
      get :approved, :unapproved, :gen_signup_link
    end
  end

  resources :ambassadors do
    collection do
      get :create_qa, :qa_list
      post :create_qa
    end
    member do
      get :show_qa, :apply_qa, :unapply_qa, :apply
      delete :destroy_qa
    end
  end

  resources :mentors do
    member do
      get :apply
    end
  end

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  require 'sidekiq/web'
  constraints lambda{|request| request.session[:admin_id] and Admin.find(request.session[:admin_id])} do
    mount Sidekiq::Web, at: '/sidekiq'
  end
end
