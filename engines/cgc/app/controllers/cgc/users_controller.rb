module Cgc
  class UsersController < BaseController
    def index
      @users = User.order(id: :desc).page(params[:page]).per(20)
    end
  end
end
