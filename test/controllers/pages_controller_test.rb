require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get partners" do
    get :partners
    assert_response :success
  end

  test "should get license" do
    get :license
    assert_response :success
  end

  test "should get terms" do
    get :terms
    assert_response :success
  end

end
