require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'home/index'
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path # 防止用户在其它窗口点击既出
    follow_redirect!
  end

  test 'login with remembering' do
    login_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test 'login without remembering' do
    # 登录并设置 cookies
    login_as(@user, remember_me: '1')
    # 再次登录并校验 cookies 被清除
    login_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
