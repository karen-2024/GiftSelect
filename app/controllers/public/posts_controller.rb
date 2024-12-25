class Public::PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_post, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "Posting was successful."
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "Posting failed."
      render :new
    end
  end

  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "You have updated post successfully."
      redirect_to post_path
    else
      @post = Post.find(params[:id])
      @post.update(post_params)
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :name, :introduction, :amount, :package, :price, :prefecture, :location, :recommend, :title, :review)
  end

  def correct_post
    @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      redirect_to posts_path
    end
  end

  def authenticate_user!
    redirect_to root_path, alert: 'ログインが必要です' unless current_user
  end

end
