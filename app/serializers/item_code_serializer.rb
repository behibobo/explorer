class ItemCodeSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :has_gift, :gift, :scan_date, :user, :item, :shop
  
  def item
    object.item
  end

  def user
    object.user
  end

  def shop
    object.item.shop unless object.item.shop.nil?
  end

  def has_gift
    !object.gift.nil?
  end

  def scan_date
    object.scan_date.to_date.to_pdate.to_s unless object.scan_date.nil?
  end
end
