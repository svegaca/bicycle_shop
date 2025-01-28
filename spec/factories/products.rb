FactoryBot.define do
  factory :product do
    name        { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    base_price  { Faker::Commerce.price(range: 0..500.0) }
  end
end
