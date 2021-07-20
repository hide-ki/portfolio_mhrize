class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  before_action :set_user, only: [:edit, :update]

  def new; end

  def create
    # emailからuserを取得して、userがいればメールを送信する
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!

    redirect_to login_path, success: 'メールが送信されました。'
  end

  def edit
    # idのところにtokenが使用されている
    # tokenからuserを取得する
    return not_authenticated if @user.blank?
  end

  def update
    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: 'パスワードを更新しました。'
    else
      flash.now[:danger] = 'パスワードの更新に失敗しました。'
      render :edit
    end
  end

  private

  def set_user
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
  end
end
