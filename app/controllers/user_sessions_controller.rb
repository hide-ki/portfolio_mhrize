class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      flash[:success] = 'ログインしました。'
      redirect_to root_path
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end
end
