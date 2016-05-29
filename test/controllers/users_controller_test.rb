require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get my_portfolio" do
    get :my_portfolio
    assert_response :success
  end

end
