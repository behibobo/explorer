class ItemCodeSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :has_gift, :gift
  
  def has_gift
    !object.gift.nil?
  end

end
