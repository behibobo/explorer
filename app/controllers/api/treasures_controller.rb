class Api::TreasuresController < ApplicationController
  before_action :set_treasure, only: [:show, :update, :destroy]

  # GET /treasures
  def index
    @treasures = Treasure.all

    render json: @treasures
  end

  # GET /treasures/1
  def show
    render json: @treasure
  end

  # POST /treasures
  def create
    @treasure = Treasure.new(treasure_params)

    if @treasure.save
      render json: @treasure, status: :created, location: @treasure
    else
      render json: @treasure.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /treasures/1
  def update
    if @treasure.update(treasure_params)
      render json: @treasure
    else
      render json: @treasure.errors, status: :unprocessable_entity
    end
  end

  # DELETE /treasures/1
  def destroy
    @treasure.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treasure
      @treasure = Treasure.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def treasure_params
      params.require(:treasure).permit(:value, :valid_to, :lat, :lng, :required_credit)
    end
end
