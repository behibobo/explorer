class CreateUserTreasures < ActiveRecord::Migration[5.1]
  def change
    create_table :user_treasures do |t|
      t.references :user, foreign_key: true
      t.integer :treasure_type
      t.datetime :date
      t.integer :value, limit: 8
      t.boolean :received, default: false

      t.timestamps
    end
  end
end
