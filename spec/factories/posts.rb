FactoryBot.define do
  factory :post do
    character_gender { 0 }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/peach-1.jpg')) }
    association :user
    association :head_armor
    association :body_armor
    association :arm_armor
    association :waist_armor
    association :foot_armor
    sequence(:title) { |n| "title_#{n}" }
  end

  trait :gentlemen do
    character_gender { :gentlemen }
  end

  trait :lady do
    character_gender { :lady }
  end

  trait :other_image do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/images.jpeg')) }
  end
end
