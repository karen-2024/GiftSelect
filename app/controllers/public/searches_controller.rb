class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @model  == "user"
      @records = User.search_for(@content, @method)
    elsif @model == 'post'
      @records = Post.search_for(@content, @method)
    elsif @model == 'tag'
      @records = Tag.search_posts_for(@content, @method)
    end

    @tag_list = Tag.all
  end

  def search_tag
    @tag = Tag.find(params[:tag_id])
    @tag_list = Tag.all
    @posts = @tag.posts
  end
end