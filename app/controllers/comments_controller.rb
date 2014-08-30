class CommentsController < ApplicationController
  
  before_action :require_login!
  
  def new
    @comment = Comment.new(post_id: params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    
    if @comment.save
      flash[:notices] = [ "Comment created!" ]
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
