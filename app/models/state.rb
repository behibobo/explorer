class State < ApplicationRecord
    has_many :users
    has_many :cities
end
