class PurchasedLoplobSerializer < ActiveModel::Serializer
  attributes :id, :date, :value

  def date
    object.date.to_date.to_pdate.to_s
  end
end
