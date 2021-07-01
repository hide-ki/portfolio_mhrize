FactoryBot.define do
  factory :post do
    character_gender { 0 }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/peach-1.jpg')) }
    association :user
  end

  trait :gentlemen do
    character_gender { :gentlemen }
  end

  trait :lady do
    character_gender { :lady }
  end

  trait :other_image do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/goodstockphotos_eyecatch-480x302.jpeg')) }
  end
end
