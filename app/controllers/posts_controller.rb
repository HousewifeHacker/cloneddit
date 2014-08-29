class PostsController < ApplicationController
  
  before_action :require_login!, except: [ :show ]
  before_action :require_author_or_moderator!, only: [ :edit, :update, :destroy ]
  
  def new
    @post = Post.new(sub_id: params[:sub_id])
  end
  
  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.sub_id = params[:sub_id]
    
    if @post.save
      flash[:notices] = [ "#{@post.title} created!" ]
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    
    if @post.update_attributes(post_params)
      flash[:notices] = [ "#{@post.title} updated!" ]
      redirect_to post_url(@post)
    else
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
  
  def require_author_or_moderator!
    post = Post.find(params[:id])
    sub = post.sub
    
    unless current_user == post.author || current_user == sub.moderator
      flash[:errors] = [ "Permission denied!" ]
      redirect_to post_url(post)
    end
  end
  
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id, :author_id)
  end
end
