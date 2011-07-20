# -*- encoding : utf-8 -*-
require 'test_helper'

class InstitutesControllerTest < ActionController::TestCase
  setup do
    @institute = institutes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:institutes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create institute" do
    assert_difference('Institute.count') do
      post :create, :institute => @institute.attributes
    end

    assert_redirected_to institute_path(assigns(:institute))
  end

  test "should show institute" do
    get :show, :id => @institute.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @institute.to_param
    assert_response :success
  end

  test "should update institute" do
    put :update, :id => @institute.to_param, :institute => @institute.attributes
    assert_redirected_to institute_path(assigns(:institute))
  end

  test "should destroy institute" do
    assert_difference('Institute.count', -1) do
      delete :destroy, :id => @institute.to_param
    end

    assert_redirected_to institutes_path
  end
end
