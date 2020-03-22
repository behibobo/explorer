class Item < ApplicationRecord
  before_create :create_unique_identifier

  belongs_to :shop
  belongs_to :user, optional: true

  def create_unique_identifier
    loop do
      self.uuid = SecureRandom.uuid()
      break unless self.class.exists?(uuid: uuid)
    end
  end
end
