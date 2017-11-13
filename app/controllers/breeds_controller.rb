class BreedsController < ApplicationController
  before_action :set_breed, only: [:show, :update, :destroy, :breed_tags, :update_breed_tags]

  # GET /breeds
  def index
    @breeds = Breed.all

    render json: @breeds, adapter: nil
  end

  # GET /breeds/1
  def show
    render json: @breed, include: [:tags], adapter: nil
  end

  # POST /breeds
  def create
    @breed = Breed.new(breed_params)

    if @breed.save
      render json: @breed, status: :created, location: @breed, adapter: nil
    else
      render json: @breed.errors, status: :unprocessable_entity, adapter: nil
    end
  end

  # PATCH/PUT /breeds/1
  def update
    # rewrite the tags if new tags are sent
    if breed_params['breed_tags_attributes'].present?
      @breed.breed_tags.delete_all
    end

    if @breed.update(breed_params)
      render json: @breed, adapter: nil
    else
      render json: @breed.errors, status: :unprocessable_entity, adapter: nil
    end
  end

  # DELETE /breeds/1
  def destroy
    @breed.destroy
  end

  def breed_tags
    render json: @breed.tags, adapter: nil
  end

  def update_breed_tags
    @breed.breed_tags.delete_all

    if @breed.update(breed_params)
      render json: @breed, adapter: nil
    else
      render json: @breed.errors, status: :unprocessable_entity, adapter: nil
    end
  end

  def stats
    @breeds = Breed.includes(:tags).all 
    render json: @breeds
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_breed
      if params[:breed_id].present?
        @breed = Breed.find(params[:breed_id])
      else
        @breed = Breed.find(params[:id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def breed_params
      params.require(:breed).permit(:name, breed_tags_attributes: [:tag_id])
    end
end
