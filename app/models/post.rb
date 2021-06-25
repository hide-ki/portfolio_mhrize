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


  # 一括してメソッドを作りたい(modelの肥大化を防止)
  def head_armor_name
    if self.head_armor.nil?
      'なし'
    else
      head_armor.name
    end
  end

  def body_armor_name
    if self.body_armor.nil?
      'なし'
    else
      body_armor.name
    end
  end

  def arm_armor_name
    if self.arm_armor.nil?
      'なし'
    else
      arm_armor.name
    end
  end

  def waist_armor_name
    if waist_armor.nil?
      'なし'
    else
      waist_armor.name
    end
  end

  def foot_armor_name
    if foot_armor.nil?
      'なし'
    else
      foot_armor.name
    end
  end
end
