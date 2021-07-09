class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]
  skip_before_action :require_login, only: [:show]

  def index; end

  def show; end

  def new
    @post = Post.new
    # 5.times{ @post.first_colors.build }
    # 5.times{ @post.second_colors.build }
    @post.first_colors_build_specify_parts
    @post.second_colors_build_specify_parts
  end

  def create
    @post = current_user.posts.build(post_params)

    # postを保存したら、colorsのpartカラムに各々部位をいれる
    if @post.save
      @post.first_color_change_part
      @post.second_color_change_part
      redirect_to root_path, success: (t '.success')
    else
      flash.now[:danger] = t '.fail'
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(update_post_params)
      redirect_to post_path(@post), success: (t '.success')
    else
      flash.now[:fail] = t '.fail'
      render :edit
    end
  end

  def destroy
    @post.destroy!
    redirect_to root_path, success: (t '.success')
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :character_gender, :image, :image_cache, :head_armor_id,
              :body_armor_id, :arm_armor_id, :waist_armor_id, :foot_armor_id,
              first_colors_attributes: [:part, :hue, :saturation, :value, :post_id],
              second_colors_attributes: [:part, :hue, :saturation, :value, :post_id]
            )
  end

  # colorsテーブルのidを追加 idの追加で、更新の度に入力欄が増加する現象を防止
  def update_post_params
    params.require(:post).permit(:title, :character_gender, :image, :image_cache, :head_armor_id,
      :body_armor_id, :arm_armor_id, :waist_armor_id, :foot_armor_id,
      first_colors_attributes: [:id, :part, :hue, :saturation, :value, :post_id],
      second_colors_attributes: [:id, :part, :hue, :saturation, :value, :post_id]
    )
  end

  def correct_user
    @post = Post.find(params[:id])
    redirect_to root_path unless current_user.admin? || current_user == @post.user
  end
end
