class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :activation_code, :username, :full_name, :credit

  def full_name
    object.full_name
  end
end
