class Item < ApplicationRecord
  belongs_to :shop
  has_many :item_codes, dependent: :destroy
end
