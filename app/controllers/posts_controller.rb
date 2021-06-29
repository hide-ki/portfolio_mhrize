class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index; end

  def show; end

  def new
    @post = Post.new
    5.times{ @post.first_colors.build }
    5.times{ @post.second_colors.build }
  end

  def create
    
    @post = current_user.posts.build(post_params)

    Post.transaction do
      @post.save
      FirstColor.transaction do
        @post.first_colors.first.update(part: 'head')
        @post.first_colors.second.update(part: 'body')
        @post.first_colors.third.update(part: 'arm')
        @post.first_colors.fourth.update(part: 'waist')
        @post.first_colors.fifth.update(part: 'foot')
        @post.second_colors.first.update(part: 'head')
        @post.second_colors.second.update(part: 'body')
        @post.second_colors.third.update(part: 'arm')
        @post.second_colors.fourth.update(part: 'waist')
        @post.second_colors.fifth.update(part: 'foot')
      end
    end
    flash[:success] = t '.success'
    redirect_to root_path
    rescue => e
    flash.now[:danger] = t '.fail'
    render :new
  end

  def edit; end

  def update
    if @post.update(update_post_params)
      flash[:success] = t '.success'
      redirect_to post_path(@post)
    else
      flash.now[:fail] = t '.fail'
      render :edit
    end
  end

  def destroy
    @post.destroy!
    flash[:success] = t '.success'
    redirect_to root_path
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:character_gender, :image, :image_cache, :head_armor_id,
              :body_armor_id, :arm_armor_id, :waist_armor_id, :foot_armor_id,
              first_colors_attributes: [:part, :hue, :saturation, :value, :post_id],
              second_colors_attributes: [:part, :hue, :saturation, :value, :post_id]
            )
  end

  # colorsテーブルのidを追加 idの追加で、更新の度に入力欄が増加する現象を防止
  def update_post_params
    params.require(:post).permit(:character_gender, :image, :image_cache, :head_armor_id,
      :body_armor_id, :arm_armor_id, :waist_armor_id, :foot_armor_id,
      first_colors_attributes: [:id, :part, :hue, :saturation, :value, :post_id],
      second_colors_attributes: [:id, :part, :hue, :saturation, :value, :post_id]
    )
  end

  def correct_user
    @post = Post.find(params[:id])
    redirect_to root_path unless current_user == @post.user
  end
end
