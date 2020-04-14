class CreatePurchasedLoplobs < ActiveRecord::Migration[5.1]
  def change
    create_table :purchased_loplobs do |t|
      t.references :user, foreign_key: true
      t.string :uuid
      t.integer :value, limit: 8
      t.datetime :date

      t.timestamps
    end
  end
end
