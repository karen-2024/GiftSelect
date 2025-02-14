class Admin::PostCommentsController < ApplicationController
  layout 'admin'

  def index
    @post_comments = PostComment.all
    @users = User.all
  end

  def destroy
    @post_comments = PostComment.find(params[:id])
    @post_comments.destroy
    redirect_to admin_post_comments_path
  end
end
