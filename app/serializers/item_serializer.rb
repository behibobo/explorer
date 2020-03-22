class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :codes, :item_count

  def item_count
    object.item_codes.count
  end

  def codes
    object.item_codes.map(&:uuid)
  end
end
