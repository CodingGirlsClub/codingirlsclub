require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name:  '', email: 'user@invalid', password: 'foo', password_confirmation: 'bar', promo_code: 'aaaa' } }
    end
    assert_template 'users/new'
  end

  test 'valid signup information with account activation' do
    promo_code = referrals(:user_referral).code
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name:  'Example User', email: 'user@example.com', password: 'password', password_confirmation: 'password', promo_code: promo_code } }
    end
    user = assigns(:user)
    assert_not user.activated?
    # 帐号激活前登录
    login_as(user)
    assert_not is_logged_in?

    # 无效的 token 激活帐号
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?

    # 错误的 email 激活帐号
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?

    # 激活帐号
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?

    follow_redirect!
    assert is_logged_in?
  end
end
