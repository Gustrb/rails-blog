class TagsController < ApplicationController
  before_action :set_tag, except: [:index, :create]

  def index
    @tags = Tag.all

    render json: @tags
  end

  def show
    render json: @tag
  end

  def create
    @tag = Tag.new tag_params

    if @tag.save
      render json: @tag, status: :created
    else
      render json: { errors: @tag.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @tag.update tag_params
      render json: @tag, status: :created
    else
      render json: { errors: @tag.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy
    head :no_content
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end

    def set_tag
      @tag = Tag.find params[:id]
    end
end
