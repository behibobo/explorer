class CreateItemCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :item_codes do |t|
      t.references :item, foreign_key: true
      t.string :uuid
      t.references :user, foreign_key: true
      t.datetime :scan_date

      t.timestamps
    end
  end
end
