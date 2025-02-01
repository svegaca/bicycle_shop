FactoryBot.define do
  factory :option_value do
    association :option_type
    name        { Faker::Commerce.color }
    description { Faker::Lorem.sentence }
    base_price  { Faker::Commerce.price(range: 10..350.0) }
    availability_type { :always_in_stock }
    stock { Faker::Number.between(from: 4, to: 20) if stock_controlled? }

    (OptionValue.availability_types.keys).each do |availability_type| # TODO: do we need this?
      trait availability_type do
        availability_type { availability_type }
      end
    end
  end
end
