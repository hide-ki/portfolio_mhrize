class StaticPagesController < ApplicationController
  skip_before_action :require_login

  def top
    @q = Post.includes(:likes).ransack(search_params)
    @posts = @q.result(distinct: true).page(params[:page]).order(created_at: :desc)
  end

  def contact; end

  def privacy; end

  private

  def search_params
    params[:q]&.permit(:character_gender_eq, :title_cont, :sorts,
                       :head_armor_name_cont, :body_armor_name_cont,
                       :arm_armor_name_cont, :waist_armor_name_cont, :foot_armor_name_cont)
  end
end
