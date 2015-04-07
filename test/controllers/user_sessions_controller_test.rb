require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase

  test "should get login page" do
    get :new
    assert_response :success
  end

  test "should login" do
    test_user = users(:one)

    post :create, login: { email: test_user.email, password: 'secret' }
    assert_redirected_to root_url
    assert_equal test_user.id, session[:user_id]
  end

  test "should fail login" do
    test_user = users(:one)

    post :create, login: { email: test_user.email, password: 'wrong' }
    assert_redirected_to login_url
    assert_nil session[:user_id]
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to login_url
    assert_nil session[:user_id]
  end
end
