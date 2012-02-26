# -*- encoding : utf-8 -*-
require 'test_helper'

class MetawelcomeControllerTest < ActionController::TestCase
  test "should get team" do
    get :team
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get sponsor" do
    get :sponsor
    assert_response :success
  end

end
