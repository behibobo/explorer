class Treasure < ApplicationRecord
    before_create :create_unique_identifier
    def create_unique_identifier
        loop do
          self.uuid = SecureRandom.uuid()
          break unless self.class.exists?(uuid: uuid)
        end
    end
end
