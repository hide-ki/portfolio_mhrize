FactoryBot.define do
  factory :foot_armor do
    sequence(:name) { |n| "フットアーマー_#{n}" }
  end
end
