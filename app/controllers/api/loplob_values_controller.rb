class Api::LoplobValuesController < ApplicationController
  before_action :set_loplob_value, only: [:show, :update, :destroy]

  # GET /loplob_values
  def index
    lop = Loplob.find(params[:loplob_id])
    @loplob_values = lop.loplob_values

    render json: @loplob_values
  end

  # GET /loplob_values/1
  def show
    render json: @loplob_value
  end

  # POST /loplob_values
  def create
    @loplob_value = LoplobValue.new(loplob_value_params)

    if @loplob_value.save
      render json: @loplob_value, status: :created
    else
      render json: @loplob_value.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /loplob_values/1
  def update
    if @loplob_value.update(loplob_value_params)
      render json: @loplob_value
    else
      render json: @loplob_value.errors, status: :unprocessable_entity
    end
  end

  # DELETE /loplob_values/1
  def destroy
    @loplob_value.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loplob_value
      @loplob_value = LoplobValue.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def loplob_value_params
      params.require(:loplob_value).permit(:loplob_id, :value, :qty)
    end
end
