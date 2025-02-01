FactoryBot.define do
  factory :product_option_value do
    association :product_option_type
    association :option_value
  end
end
