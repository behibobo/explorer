class CreateUserLoplobs < ActiveRecord::Migration[5.1]
  def change
    create_table :user_loplobs do |t|
      t.references :user, foreign_key: true
      t.string :uuid
      t.integer :value, limit: 8
      t.timestamps
    end
  end
end
