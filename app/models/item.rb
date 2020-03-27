class Item < ApplicationRecord
  belongs_to :shop, optional: true
  has_many :item_codes, dependent: :destroy

  def self.starts_with(column_name, prefix)
    where("lower(#{column_name}) like ?", "#{prefix.downcase}%")
  end

  def image_url
    unless self.image.nil?
      "194.5.205.107:3000#{self.image}"
    else
      "194.5.205.107:3000/no_image.png"
    end
  end
end
