class UserSessionsController < ApplicationController

  # GET /login
  def new
    @user = User.new
  end

  # POST /login
  def create
    login_params = params.require(:login).permit(:email, :password)
    user = User.find_by(email: login_params[:email])

    if user and user.authenticate(login_params[:password])
      login(user)
      redirect_to root_url, notice: "Login successful"
    else
      logout
      redirect_to login_url, alert: "Invalid email/password combination"
    end
  end

  # DELETE /logout
  def destroy
    logout
    redirect_to login_url, notice: "Logged out"
  end

  private
    def login(user)
      session[:user_id] = user.id
      current_user = user
    end

    def logout
      session.delete(:user_id)
      current_user = nil
    end
end
