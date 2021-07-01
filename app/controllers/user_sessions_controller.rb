class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password], params[:remember])

    if @user
      flash[:success] = t '.success'
      redirect_to root_path
    else
      flash.now[:danger] = t '.fail'
      render :new
    end
  end

  def destroy
    remember_me!
    forget_me!
    logout
    flash[:success] = t '.success'
    redirect_to login_path
  end
end
