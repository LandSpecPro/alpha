require 'test_helper'

class BusinessControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

end
