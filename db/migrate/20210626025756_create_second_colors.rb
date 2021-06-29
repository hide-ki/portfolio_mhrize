class CreateSecondColors < ActiveRecord::Migration[6.0]
  def change
    create_table :second_colors do |t|
      t.integer :part
      t.integer :hue, null: false, default: 0
      t.integer :saturation, null: false, default: 0
      t.integer :value, null: false, default: 0
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
