require 'rails_helper'
require 'support/shared_examples/combination_rule_examples'

RSpec.describe ForbiddenCombinationRule, type: :model do
  subject(:rule) { create(:forbidden_combination_rule) }

  it_behaves_like 'a combination rule'

  describe '#forbidden?' do
    it 'returns true if #applies? is true' do
      allow(rule).to receive(:applies?).and_return(true)
      expect(rule.forbidden?([1, 2])).to be(true)
    end

    it 'returns false if #applies? is false' do
      allow(rule).to receive(:applies?).and_return(false)
      expect(rule.forbidden?([1, 2])).to be(false)
    end
  end
end
