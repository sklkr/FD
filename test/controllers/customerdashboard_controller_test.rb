require 'test_helper'

class CustomerdashboardControllerTest < ActionController::TestCase
  test "should get details" do
    get :details
    assert_response :success
  end

  test "should get pass" do
    get :pass
    assert_response :success
  end

  test "should get bookings" do
    get :bookings
    assert_response :success
  end

  test "should get transactions" do
    get :transactions
    assert_response :success
  end

  test "should get preferences" do
    get :preferences
    assert_response :success
  end

  test "should get referral" do
    get :referral
    assert_response :success
  end

end
