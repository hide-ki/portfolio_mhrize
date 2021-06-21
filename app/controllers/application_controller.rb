class ApplicationController < ActionController::Base
  before_action :require_login

  private

  # require_loginで、falseになった場合にnot_authenticatedが実行される
  def not_authenticated
    redirect_to login_path
  end
end
