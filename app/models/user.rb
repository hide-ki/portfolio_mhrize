class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  enum role: { general: 0, admin: 1 }

  def own?(object)
    id == object.user_id
  end

  def like?(post)
    likes.where(post_id: post.id).exists?
  end
end
