require 'test_helper'

class MentorsControllerTest < ActionController::TestCase
  test 'should apply mentor success' do
    user   = users(:michael)
    city   = cities(:beijing)
    course = courses(:introduce_ruby)
    login_as(user)
    assert_difference('Mentor.count', 1)do
      post :create, params: {mentor: {user_id: user.id, introduce_self: 'introduction', city_id:  city.id, course_ids: [course.id]}}
    end
  end

  test 'should reject apply mentor when user dosnot login' do
    city   = cities(:beijing)
    course = courses(:introduce_ruby)
    assert_no_difference('Mentor.count') do
      post :create, params: {mentor: {user_id: nil, introduce_self: 'introduction', city_id:  city.id, course_ids: [course.id]}}
    end
  end

  test 'should reject apply mentor when user has applying' do
    user   = users(:applying_user)
    city   = cities(:beijing)
    course = courses(:introduce_ruby)
    login_as(user)
    assert_no_difference('Mentor.count')do
      post :create, params: {mentor: {user_id: user.id, introduce_self: 'introduction', city_id:  city.id, course_ids: [course.id]}}
    end
  end

  test 'should reject apply mentor when user has been an mentor' do
    user   = users(:applied_user)
    city   = cities(:beijing)
    course = courses(:introduce_ruby)
    login_as(user)
    assert_no_difference('Mentor.count')do
      post :create, params: {mentor: {user_id: user.id, introduce_self: 'introduction', city_id:  city.id, course_ids: [course.id]}}
    end
  end
end
