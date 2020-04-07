class AddGiftIdToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :item_codes, :gift, foreign_key: true
  end
end
