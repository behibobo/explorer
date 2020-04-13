class CreateTreasures < ActiveRecord::Migration[5.1]
  def change
    create_table :treasures do |t|
      t.integer :value, limit: 8
      t.datetime :valid_to
      t.string :lat
      t.string :lng
      t.integer :required_credit

      t.timestamps
    end
  end
end
