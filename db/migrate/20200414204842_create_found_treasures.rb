class CreateFoundTreasures < ActiveRecord::Migration[5.1]
  def change
    create_table :found_treasures do |t|
      t.references :user, foreign_key: true
      t.integer :value
      t.datetime :date

      t.timestamps
    end
  end
end
