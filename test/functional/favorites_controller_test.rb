require 'test_helper'

class FavoritesControllerTest < ActionController::TestCase
  test "should get products" do
    get :products
    assert_response :success
  end

  test "should get vendors" do
    get :vendors
    assert_response :success
  end

end
