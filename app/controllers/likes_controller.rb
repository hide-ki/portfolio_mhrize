class LikesController < ApplicationController
  before_action :set_post, only: [:create, :destroy]

  def create
    current_user.likes.create!(post_id: @post.id)
  end

  def destroy
    @like = current_user.likes.find_by(post_id: @post.id)
    @like.destroy!
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
