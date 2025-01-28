require 'rails_helper'

RSpec.describe CombinationRule, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:product) }

    it { is_expected.to have_many(:combination_rule_values).dependent(:destroy) }
    it { is_expected.to have_many(:option_values).through(:combination_rule_values) }
  end

  describe '#applies?' do
    let(:rule)   { create(:forbidden_combination_rule) }
    let(:ov1)    { create(:option_value) }
    let(:ov2)    { create(:option_value) }

    before do
      create(:combination_rule_value, combination_rule: rule, option_value: ov1)
      create(:combination_rule_value, combination_rule: rule, option_value: ov2)
    end

    context 'when all required option_values are selected' do
      it 'returns true' do
        selected_option_value_ids = [ov1.id, ov2.id, 9999] # can have extras
        expect(rule.applies?(selected_option_value_ids)).to be_truthy
      end
    end

    context 'when at least one required option_value is missing' do
      it 'returns false' do
        selected_option_value_ids = [ov1.id] # missing ov2
        expect(rule.applies?(selected_option_value_ids)).to be_falsey
      end
    end
  end
end
