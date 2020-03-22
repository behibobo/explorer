class ShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :image, :phone, :city, :city_id, :items, :item_count, :state, :state_id
  
  def city
    object.city.name
  end

  def city_id
    object.city.id
  end

  def state_id
    object.city.state.id
  end

  def state
    object.city.state.name
  end

  def item_count
    object.items.count
  end

  def items
    ActiveModelSerializers::SerializableResource.new(object.items)
  end
end
