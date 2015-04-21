class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private
    def current_user
      @current_user ||= User.find(session[:user_id])
    end

    def current_user=(user)
      @current_user = user
    end

    def logged_in?
      !session[:user_id].nil?
    end

    def require_user
      unless logged_in?
        store_location
        redirect_to login_url, notice: "You must be logged in to access this page"
      end
    end

    def require_no_user
      if logged_in?
        store_location
        redirect_to current_user, notice: "You must be logged out to access this page"
      end
    end

    def store_location
      session[:return_to] = request.original_url if request.get?
    end

    def store_referer
      session[:return_to] = request.env['HTTP_REFERER']
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session.delete(:return_to)
    end
end
