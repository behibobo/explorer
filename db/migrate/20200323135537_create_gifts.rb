class CreateGifts < ActiveRecord::Migration[5.1]
  def change
    create_table :gifts do |t|
      t.string :name
      t.integer :value, limit: 8

      t.timestamps
    end
  end
end
