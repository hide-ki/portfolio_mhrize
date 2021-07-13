class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authenticate_user, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: (t '.success')
    else
      # 新規登録に失敗すると、urlが/usersになってしまう
      # redirect_toを使用するなら、flashにエラーメッセージを入れる？
      flash.now[:danger] = t '.fail'
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), success: (t '.success')
    else
      flash.now[:fail] = t '.fail'
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to new_user_path, success: (t '.success')
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate_user
    user = User.find(params[:id])
    redirect_to root_path unless current_user && current_user == user
  end
end
