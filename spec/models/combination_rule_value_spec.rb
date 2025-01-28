require 'rails_helper'

RSpec.describe CombinationRuleValue, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:combination_rule) }
    it { is_expected.to belong_to(:option_value) }
  end

  describe 'validations' do
    it { is_expected.to validate_db_uniqueness_of(:option_value_id).scoped_to(:combination_rule_id) }
  end
end
