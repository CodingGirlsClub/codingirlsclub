PagesController.action_methods.each do |action|
  get "/#{action}", to: "pages##{action}", as: "#{action}_page"
end