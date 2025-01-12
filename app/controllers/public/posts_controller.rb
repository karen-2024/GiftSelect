class Public::PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_post, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tagname].split(',')
    if @post.save
      @post.save_tags(tag_list)
      flash[:notice] = "Posting was successful."
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "Posting failed."
      @posts = Post.all
      render :new
    end
  end

  def index
    @posts = Post.all.order(params[:sort])
    @post = Post.new
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @post_comment = PostComment.new
    @post_tags = @post.tags
    @tag_list = @post.tags.pluck(:tagname).join(',')
    @tag_list = Tag.all
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tagname).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:tagname].split(',')
    if @post.update(post_params)
      @post.tags.destroy_all
      @post.save_tags(tag_list)
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
    params.require(:post).permit(:image, :name, :introduction, :amount, :package, :price, :prefecture, :location, :recommend, :title, :review, :star, :tag_id)
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
