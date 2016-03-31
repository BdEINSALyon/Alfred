require 'test_helper'

class YurplanLinkControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get load" do
    get :load
    assert_response :success
  end

end
