class TreasureSerializer < ActiveModel::Serializer
  attributes :id, :value, :valid_to, :lat, :lng, :required_credit
end
