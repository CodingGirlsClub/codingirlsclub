class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  root to: 'home#index'

  # routes for websites
  draw :websites
  # routes for static pages
  draw :pages
  # routes for admin
  mount Cgc::Engine, at: '/cgc', as: :cgc
end
