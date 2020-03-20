class ItemSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :name, :brand
  has_one :shop
  has_one :user
end
