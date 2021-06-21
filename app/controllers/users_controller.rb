class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[new create]

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
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t '.success'
      redirect_to user_path(@user)
    else
      flash.now[:fail] = t '.fail'
      render :edit
    end
  end

  def destroy
    @user.destroy!
    flash[:success] = t '.success'
    redirect_to new_user_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
