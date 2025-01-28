require 'rails_helper'

RSpec.describe PriceModifierCombinationRule, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:modifier_amount) }
    it { is_expected.to validate_numericality_of(:modifier_amount).is_other_than(0) }
  end

  describe '#applicable_modifier_amount' do
    let(:rule) { create(:price_modifier_combination_rule, modifier_amount: 25) }

    context 'when #applies? is true' do
      it "returns the rule's modifier_amount" do
        allow(rule).to receive(:applies?).and_return(true)
        expect(rule.applicable_modifier_amount([1, 2])).to eq(25)
      end
    end

    context 'when #applies? is false' do
      it 'returns 0' do
        allow(rule).to receive(:applies?).and_return(false)
        expect(rule.applicable_modifier_amount([1, 2])).to eq(0)
      end
    end
  end
end
