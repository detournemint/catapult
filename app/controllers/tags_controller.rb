class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /tags
  def index
    @tags = Tag.all

    render json: @tags, adapter: nil
  end

  # GET /tags/1
  def show
    render json: @tag, adapter: nil
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: @tag, status: :created, location: @tag, adapter: nil
    else
      render json: @tag.errors, status: :unprocessable_entity, adapter: nil
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag, adapter: nil
    else
      render json: @tag.errors, status: :unprocessable_entity, adapter: nil
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
  end

  def stats
    @tags = Tag.includes(:breeds).all 
    render json: @tags
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:name)
    end
end
