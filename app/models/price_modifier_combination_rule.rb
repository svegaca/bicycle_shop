class PriceModifierCombinationRule < CombinationRule
  validates :modifier_amount, presence: true, numericality: {other_than: 0}

  def applicable_modifier_amount(selected_option_value_ids)
    return 0.to_d unless applies?(selected_option_value_ids)

    modifier_amount
  end
end
