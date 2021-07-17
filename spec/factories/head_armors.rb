FactoryBot.define do
  factory :head_armor do
    sequence(:name) { |n| "ヘッドアーマー_#{n}" }
  end
end
