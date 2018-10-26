class CommentsController < ApplicationController
  def index
    @comments = Comment.find_comments params[:description]
  end

  def new; @comment = Comment.new; end

  def create 
    @comment = Comment.new comment_params
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created'
        format.html { redirect_to @comment }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        flash[:error] = 'Something went wrong'
        format.html { render action: 'new' }
        format.json { render json: {errors: @comment.errors}, status: :unprocessable_entity }
      end
    end
  end

  def edit
    comment = Comment.find params[:id]
  end
  
  private
  def comment_params
    params.require(:comment).permit(:message, :description)
  end
end
