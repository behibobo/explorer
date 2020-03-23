class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :codes, :item_count, :image, :created_at

  def item_count
    object.item_codes.count
  end

  def codes
    object.item_codes.map(&:uuid)
  end

  def created_at
    object.created_at.to_date.to_pdate.to_s
  end
end
