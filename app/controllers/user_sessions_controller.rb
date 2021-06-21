class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      flash[:success] = t '.success'
      redirect_to root_path
    else
      flash.now[:danger] = t '.fail'
      render :new
    end
  end
end