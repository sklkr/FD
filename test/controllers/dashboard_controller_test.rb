require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should get summary" do
    get :summary
    assert_response :success
  end

end
