FactoryBot.define do
  factory :body_armor do
    sequence(:name) { |n| "ボディーアーマー_#{n}" }
  end
end
