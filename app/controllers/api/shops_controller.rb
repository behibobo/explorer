class Api::ShopsController < ApiController
  before_action :set_shop, only: [:show, :update, :destroy]

  # GET /shops
  def index
    shops = Shop.all

    shops = shops.where(state_id: params[:state_id]) if params[:state_id]
    shops = shops.where(city_id: params[:city_id]) if params[:city_id]
    
    shops = shops.starts_with('name', params[:name]) if params[:name]
    
    if params[:order] 
      if params[:order] == "city"
        if params[:desc] == "true"
          shops = shops.includes(:city).order("cities.name DESC")
        else
          shops = shops.includes(:city).order("cities.name ASC")
        end
      elsif params[:order] == "state"
        if params[:desc] == "true"
          shops = shops.includes(:state).order("states.name DESC")
        else
          shops = shops.includes(:state).order("states.name ASC")
        end
      else
        if params[:desc] == "true"
          shops = shops.order("#{params[:order]} DESC")
        else
          shops = shops.order("#{params[:order]} ASC")
        end
      end
    end

    paginate shops, per_page: (params[:per_page]) ? params[:per_page] : 15
  end


  def find_shops
    shops = Shop.all
    shops = shops.starts_with('name', params[:name]) if params[:name]
    render json: shops
  end

  # GET /shops/1
  def show
    render json: @shop
  end

  # POST /shops
  def create
    @shop = Shop.new(shop_params)

    if @shop.save
      render json: @shop, status: :created, location: @shop
    else
      render json: @shop.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shops/1
  def update
    if @shop.update(shop_params)
      render json: @shop
    else
      render json: @shop.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shops/1
  def destroy
    @shop.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shop_params
      params.require(:shop).permit(:city_id, :name, :address, :phone, :image)
    end
end
