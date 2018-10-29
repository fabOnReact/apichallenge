class CommentsController < ApplicationController
  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!
  before_action :find_comment, only: [:edit, :update, :show]
  before_action :set_comment, only: [:new, :create]

  def index
    @comments = Comment.find_comments params[:description]
  end

  def new;end

  def create 
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

  def edit; end
  
  def update 
    @comment.user = current_user
    respond_to do |format|
      if @comment.update(comment_params)
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

  def show; end

  private
  def find_comment; @comment ||= Comment.find params[:id]; end
  def set_comment; @comment ||= Comment.new comment_params; end
  def comment_params
    params.require(:comment).permit(:message, :description) unless params[:comment].nil?
  end
end
