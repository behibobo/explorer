class Api::ItemsController < ApiController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /items
  def index
    @items = Item.where(shop_id: params[:shop_id])
    render json: @items
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    params[:count].to_i.times do 
      @item = Item.new(item_params)
      @item.save        
    end
    render json: {}
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:shop_id, :name, :brand)
    end
end
