class StateSerializer < ActiveModel::Serializer
    attributes :id, :name, :user_count

    def user_count
        object.users.count
    end
  end
  