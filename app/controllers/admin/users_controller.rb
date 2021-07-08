class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[destroy]

  def destroy
    @user.destroy!
    redirect_to admin_user_path, success: (t '.success')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
