# -*- encoding : utf-8 -*-
require 'test_helper'

class CpanControllerTest < ActionController::TestCase
  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get history" do
    get :history
    assert_response :success
  end

  test "should get my_res" do
    get :my_res
    assert_response :success
  end

  test "should get my_courses" do
    get :my_courses
    assert_response :success
  end

end
