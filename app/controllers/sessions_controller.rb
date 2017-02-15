class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]
  before_action :not_login_required, only: [:new, :create]

  def new
  end

  def create
    @user = User.where(name: params[:name]).first
    if @user&.authenticate(params[:password])
      login_as @user
      redirect_to root_url
    else
      flash.not[:danger] = "name/password incorrect"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end
