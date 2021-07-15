class Admin::StaticPagesController < Admin::BaseController
  def top
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).order(created_at: :desc)
  end

  private

  def search_params
    params[:q]&.permit(:character_gender,
                       :head_armor_id, :body_armor_id, :arm_armor_id, :waist_armor_id, :foot_armor_id)
  end
end
