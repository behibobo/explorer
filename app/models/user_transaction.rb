class UserTransaction < ApplicationRecord
  belongs_to :user

  enum transaction_type: ["charge", "charge_by_admin", "scan_item", "scan_treasure", "loplob"]
end
