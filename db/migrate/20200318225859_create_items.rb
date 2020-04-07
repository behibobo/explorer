class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :shop, foreign_key: true
      t.string :uuid
      t.string :name
      t.string :brand
      t.integer :required_credit, default: 0
      t.string :image, null: true
      t.timestamps
    end
  end
end
