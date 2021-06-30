FactoryBot.define do
  factory :post do
    character_gender { 0 }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/peach-1.jpg')) }
    association :user
  end

  trait :gentlemen do
    character_gender { :gentlemen }
  end

  trait :lady do
    character_gender { :lady }
  end
end
