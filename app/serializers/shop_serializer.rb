class ShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone
  has_one :city
end
