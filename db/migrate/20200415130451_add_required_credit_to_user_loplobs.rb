class AddRequiredCreditToUserLoplobs < ActiveRecord::Migration[5.1]
  def change
    add_column :user_loplobs, :required_credit, :integer
  end
end
