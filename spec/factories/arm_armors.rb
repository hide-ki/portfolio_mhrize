FactoryBot.define do
  factory :arm_armor do
    sequence(:name) { |n| "アームーアーマー_#{n}" }
  end
end
