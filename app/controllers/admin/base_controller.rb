class Admin::BaseController < ApplicationController
  before_action :check_admin

  private

  def check_admin
    redirect_to root_path unless current_user.admin?
  end
end
