FactoryBot.define do
  factory :option_value do
    association :option_type
    name        { Faker::Commerce.color }
    description { Faker::Lorem.sentence }
  end
end
