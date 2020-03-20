class Item < ApplicationRecord
  belongs_to :shop
  belongs_to :user. optional: true
end
