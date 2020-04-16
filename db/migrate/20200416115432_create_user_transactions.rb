class CreateUserTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_transactions do |t|
      t.references :user, foreign_key: true
      t.integer :transaction_type
      t.integer :amount, limit: 8
      t.integer :credit, limit: 8
      t.timestamps
    end
  end
end
