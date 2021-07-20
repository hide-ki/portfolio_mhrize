module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: [:destroy]

    def destroy
      @user.destroy!
      redirect_to admin_user_path, success: (t '.success')
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
