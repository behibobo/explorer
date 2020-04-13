class Loplob < ApplicationRecord
    has_many :loplob_values, dependent: :destroy
end
