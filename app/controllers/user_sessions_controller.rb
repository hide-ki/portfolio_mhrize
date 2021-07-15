class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new; end

  def create
    @user = login(params[:email], params[:password], params[:remember])

    if @user&.admin?
      redirect_to admin_root_path, success: (t '.success')
    elsif @user&.general?
      redirect_to root_path, success: (t '.success')
    else
      flash.now[:danger] = t '.fail'
      render :new
    end
  end

  def destroy
    remember_me!
    forget_me!
    logout
    redirect_to login_path, success: (t '.success')
  end
end
