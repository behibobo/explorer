class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.references :city, foreign_key: true
      t.string :name
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
