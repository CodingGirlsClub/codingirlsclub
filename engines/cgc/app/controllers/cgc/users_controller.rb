module Cgc
  class UsersController < BaseController
    def index
      @users = User.all.order(id: :desc).page(params[:page]).per(20)
      #@users = User.all.order(id: :desc)
    end
  end
end
