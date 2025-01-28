class ForbiddenCombinationRule < CombinationRule
  def forbidden?(selected_option_value_ids)
    applies?(selected_option_value_ids)
  end
end
