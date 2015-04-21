require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: 'new@email.com', password: 'secret', password_confirmation: 'secret' }
    end

    @user = assigns(:user)
    assert_redirected_to user_path(@user)

    assert_equal 'new@email.com', @user.email
    assert @user.authenticate('secret')
    assert_equal 'new', @user.profile.username
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { email: 'joshdoe@example.com', password: 'new_secret', password_confirmation: 'new_secret' },
                              user_profile: { username: 'joshdoe', fullname: 'Josh Doe', bio: 'I am the 1st user.', website: 'josh.com' }
    @user = assigns(:user)
    assert_redirected_to user_path(@user)

    assert_equal 'joshdoe@example.com', @user.email
    assert @user.authenticate('new_secret')
    assert_equal 'joshdoe', @user.profile.username
    assert_equal 'Josh Doe', @user.profile.fullname
    assert_equal 'I am the 1st user.', @user.profile.bio
    assert_equal 'josh.com', @user.profile.website
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
    assert_nil User.find_by_id(@user.id)
  end
end
