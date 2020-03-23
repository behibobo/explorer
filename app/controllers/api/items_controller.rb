class Api::ItemsController < ApiController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /items
  def index
    items = Item.where(shop_id: params[:shop_id])

    items = items.starts_with('name', params[:name]) if params[:name]
    items = items.starts_with('brand', params[:brand]) if params[:brand]
    
    if params[:order] 
      if params[:desc] == "true"
        items = items.order("#{params[:order]} DESC")
      else
        items = items.order("#{params[:order]} ASC")
      end
    end
    paginate items, per_page: (params[:per_page]) ? params[:per_page] : 15
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    @item = Item.new(item_params)
    @item.save 
    params[:count].to_i.times do  
      ItemCode.create(item_id: @item.id)      
    end
    render json: ActiveModelSerializers::SerializableResource.new(@item)
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
