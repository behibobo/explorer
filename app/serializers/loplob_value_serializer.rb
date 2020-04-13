class LoplobValueSerializer < ActiveModel::Serializer
  attributes :id, :value, :qty
  has_one :loplob
end
