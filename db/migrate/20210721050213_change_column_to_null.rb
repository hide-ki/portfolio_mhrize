class ChangeColumnToNull < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :email, :string, null: true
  end

  def down
    change_column_null :users, :email, :string, null: false
  end
end
