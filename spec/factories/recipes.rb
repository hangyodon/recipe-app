FactoryBot.define do
  factory :recipe do
    title {"aaa"}
    image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpeg'))}
    calorie {100}
    sugar {"0.5"}
    category {"main"}
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    user
  end
end