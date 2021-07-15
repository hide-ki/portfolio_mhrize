class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [:destroy]

  def destroy
    @post.destroy!
    redirect_to admin_root_path, success: (t '.success')
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
