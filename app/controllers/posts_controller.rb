class PostsController < ApplicationController
  before_action :set_post, except: [:index, :create]
  before_action :set_tag, only: [:link_tag, :unlink_tag]

  before_action :authorized, except: [:index, :show]
  before_action :render_not_authorized_user, except: [:index, :create, :show]

  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    @post = Post.new post_params

    @post.user = @user

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def show
    @comments = Comment.get_ordered_comments @post.id
    @ordered_tags = @post.tags.order :name
  end

  def update
    if @post.update post_params
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head :no_content
  end

  def link_tag
    @post.tags.push @tag

    render json: @post.tags, status: :ok
  end

  def unlink_tag
    @post.tags.delete @tag

    head :no_content
  end

  private
    def is_authorized?
      @post.user == @user
    end

    def render_not_authorized_user
      unless is_authorized?
        render json: { error: 'User not authorized' }, status: :unauthorized
      end
    end

    def post_params
      params.require(:post).permit(:title, :description)
    end

    def set_post
      @post = Post.find params[:id]
    end

    def set_tag
      @tag = Tag.find params[:post][:tag_id]
    end
end
