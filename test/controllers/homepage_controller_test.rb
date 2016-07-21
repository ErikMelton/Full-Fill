require 'test_helper'

class HomepageControllerTest < ActionController::TestCase
  test "should get index," do
    get :index,
    assert_response :success
  end

  test "should get signup," do
    get :signup,
    assert_response :success
  end

  test "should get register" do
    get :register
    assert_response :success
  end

end
