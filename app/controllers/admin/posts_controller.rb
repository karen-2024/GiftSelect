class Admin::PostsController < ApplicationController
  layout 'admin'

  def index
    @posts = Post.all.order(params[:sort])
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @post_comment = PostComment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
end
