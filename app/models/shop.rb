class Shop < ApplicationRecord
  belongs_to :city
  belongs_to :state
  has_many :items, dependent: :destroy

  def self.starts_with(column_name, prefix)
    where("lower(#{column_name}) like ?", "#{prefix.downcase}%")
  end
end
