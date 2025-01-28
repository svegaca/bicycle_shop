class CombinationRuleValue < ApplicationRecord
  belongs_to :combination_rule
  belongs_to :option_value
end
