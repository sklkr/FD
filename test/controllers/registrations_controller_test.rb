require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  test "should get supplier" do
    get :supplier
    assert_response :success
  end

  test "should get customer" do
    get :customer
    assert_response :success
  end

end
