require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name:  '', email: 'user@invalid', password: 'foo', password_confirmation: 'bar', promo_code: 'aaaa' } }
    end
    assert_template 'users/new'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name:  'Example User', email: 'user@example.com', password: 'password', password_confirmation: 'password', promo_code: 'aaaa' } }
    end
  end
end
