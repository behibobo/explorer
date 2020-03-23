class Gift < ApplicationRecord
    has_many :item_codes
    
    def self.starts_with(column_name, prefix)
        where("lower(#{column_name}) like ?", "#{prefix.downcase}%")
    end
end
