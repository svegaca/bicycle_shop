class CombinationRule < ApplicationRecord
 belongs_to :product

  has_many :combination_rule_values, dependent: :destroy
  has_many :option_values, through: :combination_rule_values

  accepts_nested_attributes_for :combination_rule_values, allow_destroy: true, reject_if: :all_blank

  def applies?(selected_option_value_ids)
    (option_value_ids - selected_option_value_ids.map(&:to_i)).empty?
  end
end
