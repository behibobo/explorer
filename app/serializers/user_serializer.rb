class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :activation_code, :mobile, :full_name, :city

  def full_name
    object.full_name
  end
  
  def city
    object.city.name
  end
end
