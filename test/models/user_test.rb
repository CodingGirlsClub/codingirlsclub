require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar', promo_code: 'aaa')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ' '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 175 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid address' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                             first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid? "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid address' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                               foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email address should be unique' do
    duplicate_user       = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email address should be saved as lower-case' do
    mixed_user_email = 'Foo@ExAMPle.CoM'
    @user.email      = mixed_user_email
    @user.save
    assert_equal mixed_user_email.downcase, @user.reload.email
  end

  test 'password should be present (not blank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password should has a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'password should not too long' do
    @user.password = @user.password_confirmation = 'a' * 21
    assert_not @user.valid?
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?(:remember, '')
  end

  test 'promo_code should existed' do
    @user.promo_code = 'didfifdof'
    @user.save
    assert_not @user.valid?
  end

  test 'promo_code should not expired if promo_code is a system code' do
    promo_code = referrals(:system_expired_referral)
    @user.promo_code = promo_code
    @user.save
    assert_not @user.valid?
  end

  test 'create a user with not expired system promo_code' do
    promo_code = referrals(:system_active_referral)
    @user.save
    assert @user.valid?
  end
end
