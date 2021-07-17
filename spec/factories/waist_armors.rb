FactoryBot.define do
  factory :waist_armor do
    sequence(:name) { |n| "ウェストアーマー_#{n}" }
  end
end
