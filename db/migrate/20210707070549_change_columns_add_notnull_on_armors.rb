class ChangeColumnsAddNotnullOnArmors < ActiveRecord::Migration[6.0]
  def change
    change_column :armors, :type, :string, null: false
    change_column :armors, :name, :string, null: false
  end
end
