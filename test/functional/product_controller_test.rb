require 'test_helper'

class ProductControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get browse" do
    get :browse
    assert_response :success
  end

  test "should get favorite" do
    get :favorite
    assert_response :success
  end

end
