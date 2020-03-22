class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.references :city, foreign_key: true
      t.references :state, foreign_key: true
      t.string :name
      t.string :address
      t.string :phone
      t.string :image, null: true
      t.timestamps
    end
  end
end
