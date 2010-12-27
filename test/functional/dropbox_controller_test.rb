require 'test_helper'

class DropboxControllerTest < ActionController::TestCase
  test "should get authorize" do
    get :authorize
    assert_response :success
  end

  test "should get import" do
    get :import
    assert_response :success
  end

end
