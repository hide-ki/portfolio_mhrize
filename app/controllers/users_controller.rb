class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t '.success'
      redirect_to root_path
    else
      flash.now[:danger] = t '.fail'
      render :new
    end
  end

  def show
  # 後々、showアクションに自分の投稿を一覧で表示させる
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
