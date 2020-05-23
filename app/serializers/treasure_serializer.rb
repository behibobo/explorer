class TreasureSerializer < ActiveModel::Serializer
  attributes :id, :value, :valid_to, :lat, :lng, :required_credit, :state_id, :valid_to_shamsi, :state

  def valid_to_shamsi
    object.valid_to&.to_date&.to_pdate&.to_s&.gsub("-", "/")
  end

  def state
    object.state.name
  end

end
