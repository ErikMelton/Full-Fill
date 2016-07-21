require 'test_helper'

class SigninControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get signin" do
    get :signin
    assert_response :success
  end

  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get forgotpass" do
    get :forgotpass
    assert_response :success
  end

end
