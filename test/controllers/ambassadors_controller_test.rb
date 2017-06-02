require 'test_helper'

class AmbassadorsControllerTest < ActionController::TestCase
  test 'should apply ambassador success' do
    user     = users(:university_user)
    question = questions(:valid_ambassador_qa_question)
    login_as(user)
    assert_difference('Ambassador.count', 1)do
      post :create, params: {ambassador: {user_id: user.id, self_introduction: 'introduction'}, answers: [{question.id => 'aaa'}]}
    end
  end

  test 'should reject apply ambassador when user dosnot login' do
    user     = users(:university_user)
    question = questions(:valid_ambassador_qa_question)
    assert_no_difference('Ambassador.count') do
      post :create, params: {ambassador: {user_id: user.id, self_introduction: 'introduction'}, answers: [{question.id => 'aaa'}]}
    end
  end

  test 'should reject apply ambassador when user is not a university student' do
    user     = users(:maggie)
    question = questions(:valid_ambassador_qa_question)
    login_as(user)
    assert_no_difference('Ambassador.count') do
      post :create, params: {ambassador: {user_id: user.id, self_introduction: 'introduction'}, answers: [{question.id => 'aaa'}]}
    end
  end

  test 'should reject apply ambassador when question is not answered' do
    user     = users(:university_user)
    question = questions(:valid_ambassador_qa_question)
    login_as(user)
    assert_no_difference('Ambassador.count')do
      post :create, params: {ambassador: {user_id: user.id, self_introduction: 'introduction'}, answers: [{question.id => ''}]}
    end
  end

  test 'should reject apply ambassador when user has applying' do
    user     = users(:applying_user)
    question = questions(:valid_ambassador_qa_question)
    login_as(user)
    assert_no_difference('Ambassador.count')do
      post :create, params: {ambassador: {user_id: user.id, self_introduction: 'introduction'}, answers: [{question.id => 'bbb'}]}
    end
  end

  test 'should reject apply ambassador when user has been an ambassador' do
    user     = users(:applied_user)
    question = questions(:valid_ambassador_qa_question)
    login_as(user)
    assert_no_difference('Ambassador.count')do
      post :create, params: {ambassador: {user_id: user.id, self_introduction: 'introduction'}, answers: [{question.id => 'bbb'}]}
    end
  end
end
