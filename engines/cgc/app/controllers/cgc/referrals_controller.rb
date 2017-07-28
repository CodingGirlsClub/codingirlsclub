module Cgc
  class ReferralsController < BaseController
    def index
      @referrals       = Referral.where(user_id: nil).order(id: :desc).page(params[:page]).per(20)
      @referrals_count = @referrals.count
    end

    def create
      referral_params = Array.new(10, { expired_at: Time.current })
      Referral.create!(referral_params)

      flash[:success] = '邀请码创建成功'
      redirect_to referrals_path
    end
  end
end
