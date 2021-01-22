class CommentsController < ApplicationController
  before_action :set_post, only: [:index, :create]
  before_action :set_comment, only: [:show, :update, :destroy]

  before_action :authorized, except: [:index, :show]

  def index
    @comments = Comment.where post: params[:post_id]

    render json: @comments
  end

  def show
    render json: @comment
  end

  def create
    @comment = @post.comments.new comment_params
    set_current_user_to_author

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors }, status: :unprocessable_entity
    end
  end

  def update
    unless is_author?
      render json: { errors: 'User must be authenticated' }, status: :unauthorized
    end

    if @comment.update comment_params
      render json: @comment, status: :ok
    else
      render json: { errors: @comment.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if is_allowed_to_destroy?
      @comment.destroy
      head :no_content
    else
      render json: { errors: 'User must be authenticated' }, status: :unauthorized
    end
  end

  private
    def is_author?
      @comment.user == @user
    end

    def is_allowed_to_destroy?
      @comment.user == @user or @comment.post.user == @user
    end

    def comment_params
      params.require(:comment).permit(:text)
    end

    def set_current_user_to_author
      @comment.user = @user
    end

    def set_post
      @post = Post.find params[:post_id]
    end

    def set_comment
      @comment = Comment.find params[:id]
    end
end
