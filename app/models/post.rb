class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :head_armor, optional: true
  belongs_to :body_armor, optional: true
  belongs_to :arm_armor, optional: true
  belongs_to :waist_armor, optional: true
  belongs_to :foot_armor, optional: true

  validates :character_gender, presence: true
  # imageカラムのバリデーションをカスタムする
  # エラーメッセージの内容を変更したい(今のままでは不自然)
  validates :image, presence: true

  enum character_gender: { gentlemen: 0, lady: 1 }


  def armor_name(object)
    if object.nil?
      'なし'
    else
      object.name
    end
  end

  # もう少し編集したい
  def armors
    [head_armor, body_armor, arm_armor, waist_armor, foot_armor]
  end
end
