FactoryBot.define do
  factory :combination_rule do
    association :product
    description { Faker::Lorem.sentence }

    factory :forbidden_combination_rule, class: 'ForbiddenCombinationRule' do
      type { 'ForbiddenCombinationRule' }
    end

    factory :price_modifier_combination_rule, class: 'PriceModifierCombinationRule' do
      type { 'PriceModifierCombinationRule' }
      modifier_amount { Faker::Commerce.price(range: 10..50.0) }
    end
  end
end
