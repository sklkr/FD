require 'test_helper'

class CentersControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get services" do
    get :services
    assert_response :success
  end

  test "should get map" do
    get :map
    assert_response :success
  end

  test "should get reviews" do
    get :reviews
    assert_response :success
  end

  test "should get instructors" do
    get :instructors
    assert_response :success
  end

  test "should get experience" do
    get :experience
    assert_response :success
  end

  test "should get hours" do
    get :hours
    assert_response :success
  end

  test "should get upcoming" do
    get :upcoming
    assert_response :success
  end

end
