class CombinationRuleValue < ApplicationRecord
 belongs_to :combination_rule
 belongs_to :option_value

  # validates_db_uniqueness_of :option_value_id, scope: :combination_rule_id
end
