class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :set_user, :only => [:show, :destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      @user = User.find(params[:id])
      @user.update(user_params)
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
    flash[:notice] = '退会しました。'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

  def set_user
    @user = User.find_by(:id => params[:id])
  end

  def authenticate_user!
    redirect_to root_path, alert: 'ログインが必要です' unless current_user
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to posts_path(current_user)
    end
  end

end
