class PostsController < ApplicationController

  def index; end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = t '.success'
      redirect_to root_path
    else
      flash.now[:danger] = t '.fail'
      render :new
    end
  end


  private

  def post_params
    params.require(:post).permit(:character_gender)
  end
end
