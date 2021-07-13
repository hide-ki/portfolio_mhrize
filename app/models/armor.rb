class Armor < ApplicationRecord
  has_many :posts
  
  validates :type, presence: true
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
end
