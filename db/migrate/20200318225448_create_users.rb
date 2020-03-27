class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: true
      t.string :last_name, null: true
      t.string :mobile
      t.integer :gender, limit: 1, null: true
      t.integer :credit, limit: 8, default: 0
      t.date :dob, null: true
      t.string :nid, null: true
      t.string :activation_code
      t.string :password_digest
      t.references :state, foreign_key: true
      t.references :city, foreign_key: true
      t.timestamps
    end
  end
end
