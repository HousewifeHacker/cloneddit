class SubsController < ApplicationController

  before_action :require_login!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :require_moderator!, only: [ :edit, :update, :destroy ]

  def index
    @subs = Sub.all
  end
    
  def show
    @sub = Sub.find(params[:id])
  end
  
  def new
    @sub = Sub.new
  end
  
  def create
    @sub = Sub.new(subs_params)
    @sub.moderator_id = current_user.id
    
    if @sub.save
      flash[:notices] = [ "#{@sub.title} created!" ]
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def edit
    @sub = Sub.find(params[:id])
  end
  
  def update
    @sub = Sub.find(params[:id])
    @sub.update_attributes(subs_params)
    
    if @sub.save
      flash[:notices] = [ "#{@sub.title} updated!" ]
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end
  
  private
  
  def require_moderator! 
    @sub = Sub.find(params[:id])
    
    if current_user != @sub.moderator
      flash[:errors] = [ "Permission denied!" ]
      redirect_to sub_url(@sub)
    end 
  end
  
  def subs_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end
end
