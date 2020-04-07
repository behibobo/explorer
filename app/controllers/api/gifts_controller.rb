class Api::GiftsController < ApiController
  before_action :set_gift, only: [:show, :update, :destroy]

  # GET /gifts
  def index
    gifts = Gift.all
    gifts = gifts.where(name: params[:name]) if params[:name]
    
    render json: gifts
  end


  # GET /gifts/1
  def show
    render json: @gift
  end

  # POST /gifts
  def create
    gift = Gift.new(gift_params)
    gift.save
    render json: gift
  end

  # PATCH/PUT /gifts/1
  def update
    @gift.update(gift_params)
    render json: @gift
  end

  # DELETE /gifts/1
  def destroy
    @gift.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift
      @gift = Gift.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def gift_params
      params.require(:gift).permit(:name, :value)
    end
end
