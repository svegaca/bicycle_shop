FactoryBot.define do
  factory :combination_rule_value do
    association :combination_rule
    association :option_value
  end
end
