class PostsController < ApplicationController
  
  before_action :require_login!, except: [ :show ]
  before_action :require_author!, only: [ :edit, :update ]
  
  def new
    @post = Post.new
    @subs = Sub.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.author = current_user
    
    if @post.save
      flash[:notices] = [ "#{@post.title} created!" ]
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
  end
  
  def update
    @post = Post.find(params[:id])
  
    if @post.update_attributes(post_params)
      flash[:notices] = [ "#{@post.title} updated!" ]
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notices] = [ "#{@post.title} deleted!" ]
    redirect_to sub_url(@post.sub)
  end
  
  private
  
  def require_author!
    post = Post.find(params[:id])
    
    unless current_user == post.author
      flash[:errors] = [ "Permission denied!" ]
      redirect_to post_url(post)
    end
  end
  
  def post_params
    params.require(:post)
      .permit(:title, :url, :content, :author_id, sub_ids: [])
  end
end
