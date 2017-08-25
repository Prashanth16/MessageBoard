class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @message=Message.find(params[:message_id])
    @comment = @message.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to message_path(@message)
    else
      render 'new'
    end
  end

  def edit
    @message = Message.find(params[:message_id])
    @comment = @message.comments.find(params[:id])
  end

  def show
    @message = Message.find(params[:message_id])
    @comment = @message.comments.find(params[:id])
    binding.pry
  end

  def update
    @message = Message.find(params[:message_id])
    @comment = @message.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to message_path(@message)
    else
      render 'edit'
    end
  end

  # def destroy
  #   @comment.destroy
  #   redirect_to message_path(@message)
  # end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
