class CitySerializer < ActiveModel::Serializer
    attributes :id, :state_id, :name, :user_count

    def user_count
        object.users.count
    end
end
  