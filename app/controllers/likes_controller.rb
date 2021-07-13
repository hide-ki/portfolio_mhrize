class LikesController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    current_user.likes.create(post_id: @post.id)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: @post.id)
    @like.destroy!
    redirect_back(fallback_location: root_path)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
