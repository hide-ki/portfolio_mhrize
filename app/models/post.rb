class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :first_colors, dependent: :destroy
  has_many :second_colors, dependent: :destroy

  accepts_nested_attributes_for :first_colors, :second_colors

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

  def armors
    [head_armor, body_armor, arm_armor, waist_armor, foot_armor]
  end

  def first_color_change_part
    first_colors.first.update(part: 'head')
    first_colors.second.update(part: 'body')
    first_colors.third.update(part: 'arm')
    first_colors.fourth.update(part: 'waist')
    first_colors.fifth.update(part: 'foot')
  end

  def second_color_change_part
    second_colors.first.update(part: 'head')
    second_colors.second.update(part: 'body')
    second_colors.third.update(part: 'arm')
    second_colors.fourth.update(part: 'waist')
    second_colors.fifth.update(part: 'foot')  
  end
end
