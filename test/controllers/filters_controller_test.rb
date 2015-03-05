require 'test_helper'

class FiltersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get grid" do
    get :grid
    assert_response :success
  end

  test "should get map" do
    get :map
    assert_response :success
  end

end
