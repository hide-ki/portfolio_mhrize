class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update]

  def index; end

  def show; end

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

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = t '.success'
      redirect_to post_path(@post)
    else
      flash.now[:fail] = t '.fail'
      render :edit
    end
  end


  private


  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:character_gender)
  end
end
