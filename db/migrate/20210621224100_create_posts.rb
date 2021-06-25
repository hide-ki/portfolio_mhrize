class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.belongs_to :head_armor
      t.belongs_to :body_armor
      t.belongs_to :arm_armor
      t.belongs_to :waist_armor
      t.belongs_to :foot_armor
      t.integer :character_gender, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
