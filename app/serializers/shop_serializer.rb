class ShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone, :city
  def city
    object.city.name
  end
end
