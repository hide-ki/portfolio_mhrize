class ChangeColumnAddUniqueToArmors < ActiveRecord::Migration[6.0]
  def change
    change_column :armors, :name, :string, unique: true
    add_index :armors, :name
  end
end
