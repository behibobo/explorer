class CreateLoplobValues < ActiveRecord::Migration[5.1]
  def change
    create_table :loplob_values do |t|
      t.references :loplob, foreign_key: true
      t.integer :value, limit: 8
      t.integer :qty

      t.timestamps
    end
  end
end
