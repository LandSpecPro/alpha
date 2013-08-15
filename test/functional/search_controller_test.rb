require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get product" do
    get :product
    assert_response :success
  end

  test "should get supplier" do
    get :supplier
    assert_response :success
  end

end
