class SecondColor < ApplicationRecord
  belongs_to :post, optional: true

  enum part: { head: 0, body: 1, arm: 2, waist: 3, foot: 4 }

  validates :hue, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 360 }
  validates :saturation, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :value, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
