class Item < ApplicationRecord
  belongs_to :shop, optional: true
  has_many :item_codes, dependent: :destroy

  def self.starts_with(column_name, prefix)
    where("lower(#{column_name}) like ?", "#{prefix.downcase}%")
  end
end
