module Cgc
  class UsersController < BaseController
    def index
      # 回填城市搜索内容
      if params[:q] && params[:q][:city_id_eq].present?
        @city_default_value = [City.find_by(id: params[:q][:city_id_eq])&.province, params[:q][:city_id_eq]]
      end

      # 回填学校搜索内容
      if params[:q] && params[:q][:city_id_eq].present? && params[:q][:university_id_eq].present?
        @university_default_value = [University.find_by(id: params[:q][:university_id_eq])&.name, params[:q][:university_id_eq]]
      end

      @search      = User.ransack(params[:q])
      @users       = @search.result.includes(:city, :university).order(id: :desc).page(params[:page])
      @users_count = @search.result.count
    end
  end
end
