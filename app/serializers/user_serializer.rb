class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :activation_code, :mobile, :full_name, :city, :history, :dob, :credit

  def full_name
    object.full_name
  end
  
  def dob
    object.dob.to_date.to_pdate.to_s
  end

  def city
    object.city.name
  end

  def history
    ActiveModelSerializers::SerializableResource.new(object.item_codes)
  end
end
