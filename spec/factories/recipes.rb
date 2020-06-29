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

  factory :recipe_with_material, class: Recipe do
    name {"sample"}
    amount {"1"}

    after(:create) do |recipe|
      create :material, recipe: recipe
    end
  end

  factory :recipe_with_step, class: Recipe do
    number {1}
    process {"test"}

    after(:create)  do |recipe|
      create :step, recipe: recipe
    end
  end
end