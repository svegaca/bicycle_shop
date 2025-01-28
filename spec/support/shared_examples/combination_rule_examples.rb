RSpec.shared_examples 'a combination rule' do
  describe 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to have_many(:combination_rule_values).dependent(:destroy) }
    it { is_expected.to have_many(:option_values).through(:combination_rule_values) }
  end

  describe '#applies?' do
    let(:rule) { subject } # instantiate the actual subclass in the child spec
    let(:ov1)  { create(:option_value) }
    let(:ov2)  { create(:option_value) }

    before do
      create(:combination_rule_value, combination_rule: rule, option_value: ov1)
      create(:combination_rule_value, combination_rule: rule, option_value: ov2)
    end

    it 'returns true if all required option_values are selected' do
      selected_ids = [ov1.id, ov2.id, 9999] # can contain extra values
      expect(rule.applies?(selected_ids)).to be true
    end

    it 'returns false if at least one required option_value is missing' do
      selected_ids = [ov1.id] # missed ov2 to match the rule
      expect(rule.applies?(selected_ids)).to be false
    end
  end
end
