class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    redirect_to login_url if params[:denied].present?
    if @user = login_from(provider)
      redirect_to root_path
    else
      @user = create_from(provider)
      reset_session
      auto_login(@user)
      redirect_to root_path
    end
  end
end
