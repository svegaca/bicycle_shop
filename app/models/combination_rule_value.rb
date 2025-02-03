class CombinationRuleValue < ApplicationRecord
  db_belongs_to :combination_rule
  db_belongs_to :option_value

  validates_db_uniqueness_of :option_value_id, scope: :combination_rule_id
end
