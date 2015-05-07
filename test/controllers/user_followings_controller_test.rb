require 'test_helper'

class UserFollowingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should follow" do
    assert false, "Not implemented"
  end

  test "should unfollow" do
    assert false, "Not implemented"
  end

end
