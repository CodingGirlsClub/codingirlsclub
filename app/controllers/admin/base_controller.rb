class Admin::BaseController < ActionController::Base
  layout 'admin'
  helper_method :current_admin, :admin_logined?

  before_action :require_admin_login
  before_action :http_basic_authenticate
  protect_from_forgery with: :exception

  private

  def http_basic_authenticate
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |name, password|
        name == 'cgc' && password == '2017pwd_cgc_dwp7102'
      end
    end
  end

  def admin_logined?
    !!current_admin
  end

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end

  def require_admin_login
    unless admin_logined?
      redirect_to admin_login_path
    end
  end
end