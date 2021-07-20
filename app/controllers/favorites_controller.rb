class FavoritesController < ApplicationController
  before_action :authenticate_user, only: [:index]

  def index
    @q = current_user.like_posts.includes(:user, :likes).ransack(search_params)
    @posts = @q.result(distinct: true).page(params[:page]).order(created_at: :desc)
  end

  private

  def authenticate_user
    user = User.find_by(id: params[:user_id])
    redirect_to root_path unless user && user.id == current_user.id
  end

  def search_params
    params[:q]&.permit(:character_gender_eq, :title_cont, :sorts,
                       :head_armor_name_cont, :body_armor_name_cont,
                       :arm_armor_name_cont, :waist_armor_name_cont, :foot_armor_name_cont)
  end
end
