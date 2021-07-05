class MypagesController < ApplicationController
  before_action :authenticate_user, only: [:index]

  def index
    @q = current_user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).order(created_at: :desc)
  end

  private

  def authenticate_user
    user = User.find_by(id: params[:user_id])
    redirect_to root_path unless user && user.id == current_user.id
  end
end
