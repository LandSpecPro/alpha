require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get dashboard_main" do
    get :dashboard_main
    assert_response :success
  end

  test "should get dashboard_weekly" do
    get :dashboard_weekly
    assert_response :success
  end

  test "should get dashboard_email" do
    get :dashboard_email
    assert_response :success
  end

  test "should get user_view" do
    get :user_view
    assert_response :success
  end

end
