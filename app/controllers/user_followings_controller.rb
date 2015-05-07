class UserFollowingsController < ApplicationController
  before_action :set_user

  # GET /users/1/following
  def index
  end

  # POST /users/1/following
  def create
    @user.follow(params[:id])

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User was successfully followed.' }
      else
        format.html { redirect_to users_url }
      end
    end
  end

  # DELETE /users/1/following/1
  def destroy
    @user.user_followings.find_by(following_id: params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully unfollowed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end
end
