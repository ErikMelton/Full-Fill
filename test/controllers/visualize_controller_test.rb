require 'test_helper'

class VisualizeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get report" do
    get :report
    assert_response :success
  end

end
