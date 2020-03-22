class ShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :image, :phone, :city, :items, :item_count
  
  def city
    object.city.name
  end

  def item_count
    object.items.count
  end

  def items
    ActiveModelSerializers::SerializableResource.new(object.items)
  end
end
