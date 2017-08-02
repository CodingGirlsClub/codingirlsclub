require_dependency 'cgc/application_controller'

module Cgc
  class BaseController < ApplicationController
    protect_from_forgery with: :exception

    helper_method :current_admin, :admin_logined?

    before_action :require_admin_login

    def login(admin)
      session[:admin_id] = admin.id
    end

    def logout
      session.delete(:admin_id)
    end

    private

    def admin_logined?
      !!current_admin
    end

    def current_admin
      @current_admin ||= Admin.find_by(id: session[:admin_id])
    end

    def require_admin_login
      unless admin_logined?
        redirect_to login_path
      end
    end
  end
end
