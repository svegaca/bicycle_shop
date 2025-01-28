FactoryBot.define do
  factory :product_option_type do
    association :product
    association :option_type
  end
end
