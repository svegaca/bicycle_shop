FactoryBot.define do
  factory :option_type do
    name        { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end
end
