class CreateLoplobs < ActiveRecord::Migration[5.1]
  def change
    create_table :loplobs do |t|
      t.integer :required_credit
      t.integer :qty

      t.timestamps
    end
  end
end
