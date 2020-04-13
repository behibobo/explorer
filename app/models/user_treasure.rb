class UserTreasure < ApplicationRecord
  belongs_to :user
  treasure_type: ["loplob", "treasure"]
end
