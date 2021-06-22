class StaticPagesController < ApplicationController
  skip_before_action :require_login

  def top
    @posts = Post.all
  end
end
