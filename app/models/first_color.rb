class FirstColor < ApplicationRecord
  belongs_to :post, optional: true

  enum part: { head: 0, body: 1, arm: 2, waist: 3, foot: 4 }

  # validationを設定する
end
