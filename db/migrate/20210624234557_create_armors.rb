class CreateArmors < ActiveRecord::Migration[6.0]
  def change
    create_table :armors do |t|
      t.string :type
      t.string :name

      t.timestamps
    end
  end
end
