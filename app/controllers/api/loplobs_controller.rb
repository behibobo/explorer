class Api::LoplobsController < ApplicationController
  before_action :set_loplob, only: [:show, :update, :destroy]

  # GET /loplobs
  def index
    @loplobs = Loplob.all

    render json: @loplobs
  end

  # GET /loplobs/1
  def show
    render json: @loplob
  end

  # POST /loplobs
  def create
    @loplob = Loplob.new(loplob_params)

    if @loplob.save
      render json: @loplob, status: :created, location: @loplob
    else
      render json: @loplob.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /loplobs/1
  def update
    if @loplob.update(loplob_params)
      render json: @loplob
    else
      render json: @loplob.errors, status: :unprocessable_entity
    end
  end

  # DELETE /loplobs/1
  def destroy
    @loplob.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loplob
      @loplob = Loplob.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def loplob_params
      params.require(:loplob).permit(:required_credit, :qty)
    end
end
