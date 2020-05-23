class TreasureSerializer < ActiveModel::Serializer
  attributes :id, :value, :valid_to, :lat, :lng, :required_credit, :state_id, :valid_to_shamsi

  def valid_to_shamsi
    object.valid_to&.to_date&.to_pdate&.to_s&.gsub("-", "/")
  end
end
