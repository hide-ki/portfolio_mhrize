class SecondColor < ApplicationRecord
  belongs_to :post, optional: true

  enum part: { head: 0, body: 1, arm: 2, waist: 3, foot: 4 }

  validates :hue, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 300 }
  validates :saturation, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 300 }
  validates :value, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 300 }
end
