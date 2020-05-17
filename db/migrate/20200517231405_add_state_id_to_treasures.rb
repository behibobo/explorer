class AddStateIdToTreasures < ActiveRecord::Migration[5.1]
  def change
    add_column :treasures, :state_id, :int, null: true
  end
end
