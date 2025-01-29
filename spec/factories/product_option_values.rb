FactoryBot.define do
  factory :product_option_value do
    association :product_option_type
    association :option_value
    availability_type { :always_in_stock }
    stock { Faker::Number.between(from: 4, to: 20) if stock_controlled? }

    (ProductOptionValue.availability_types.keys).each do |availability_type|
      trait availability_type do
        availability_type { availability_type }
      end
    end
  end
end
