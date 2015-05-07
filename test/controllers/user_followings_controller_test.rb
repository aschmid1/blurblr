require 'test_helper'

class UserFollowingsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @followed_user = users(:two)
  end

  test "should get index" do
    get :index, user_id: @user
    assert_response :success
  end

  test "should follow" do
    assert_difference('@followed_user.following.count') do
      post :create, user_id: @followed_user, id: @user
    end
    assert @followed_user.is_following? @user
    assert_redirected_to users_path
  end

  test "should unfollow" do
    assert_difference('@user.following.count', -1) do
      delete :destroy, user_id: @user, id: @followed_user
    end
    assert_not @user.is_following? @followed_user
    assert User.exists? @followed_user.id
    assert_redirected_to users_path
  end

end
