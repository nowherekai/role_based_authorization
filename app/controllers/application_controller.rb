class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate

  helper_method :current_user, :login?

  private

    def authenticate
      redirect_to login_path unless login?
    end

    def login?
      !!current_user
    end

    def current_user
      @current_user ||= login_from_session unless defined?(@current_user)
      @current_user
    end

    def login_from_session
      User.find session[:user_id] if session[:user_id]
    rescue ActiveRecord::NotFound
      session[:user_id] = nil
    end

    def login_as(user)
      @current_user = user
      session[:user_id] = user.id
    end

    def not_login_required
      redirect_to root_path if login?
    end

    def logout
      @current_user = nil
      session[:user_id] = nil
    end
end
