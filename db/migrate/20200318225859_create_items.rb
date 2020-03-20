class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :shop, foreign_key: true
      t.string :uuid
      t.string :name
      t.string :brand
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
