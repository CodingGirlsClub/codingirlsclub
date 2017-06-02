class CitiesController < ApplicationController
  def search
    cities = City.all.where(level: 1).select(:id, :province).where('province like :city_info', city_info: "%#{params[:q]}%").limit(10)

    respond_to do |format|
      format.json { render json: cities }
    end
  end

  def search_universities
    universities = University.where(city_id: params[:id]).select(:id, :name).where('name like :universty_info', universty_info: "%#{params[:q]}%").limit(10)

    respond_to do |format|
      format.json { render json: universities }
    end
  end
end
