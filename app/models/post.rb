class Post < ApplicationRecord
  belongs_to :user

  validates :character_gender, presence: true

  enum character_gender: { gentlemen: 0, lady: 1 }
end
