class UserTransactionSerializer < ActiveModel::Serializer
  attributes :id, :type, :amount, :date

  def date
    object.created_at.to_date.to_pdate.to_s
  end

  def type
    UserTransaction.transaction_types[object.transaction_type]
  end
end
