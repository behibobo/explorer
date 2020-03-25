class ItemCodeSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :has_gift, :gift, :scan_date, :item
  
  def item
    object.item
  end

  def has_gift
    !object.gift.nil?
  end

  def scan_date
    object.scan_date.to_date.to_pdate.to_s
  end
end
