class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user

  validates :character_gender, presence: true
  # imageカラムのバリデーションをカスタムする
  # エラーメッセージの内容を変更したい(今のままでは不自然)
  validates :image, presence: true

  enum character_gender: { gentlemen: 0, lady: 1 }
end
