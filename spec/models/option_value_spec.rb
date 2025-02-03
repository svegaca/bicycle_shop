require 'rails_helper'

RSpec.describe OptionValue, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:option_type) }
    it { is_expected.to have_many(:product_option_values).dependent(:restrict_with_error) }
  end

  describe 'validations' do
    it { is_expected.to validate_inclusion_of(:availability_type).in_array(described_class.availability_types.keys) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_numericality_of(:base_price).is_greater_than_or_equal_to(0) }

    describe 'stock' do
      it { is_expected.not_to validate_numericality_of(:stock).only_integer }

      context 'when availability depends on the stock' do
        before { subject.availability_type = :stock_controlled }

        it { is_expected.to validate_numericality_of(:stock).only_integer }
      end
    end
  end

  describe '#available?' do
    subject(:available) { option_value.available? }

    let(:option_value) { build_stubbed(:option_value, availability) }

    context 'when availability_type is :always_in_stock' do
      let(:availability) { :always_in_stock }

      it { is_expected.to be_truthy }
    end

    context 'when availability_type is :out_of_stock' do
      let(:availability) { :out_of_stock }

      it { is_expected.to be_falsey }
    end

    context 'when availability_type is :stock_controlled' do
      let(:availability) { :stock_controlled }

      context 'with stock' do
        before { option_value.stock = 5 }

        it { is_expected.to be_truthy }
      end

      context 'without stock' do
        before { option_value.stock = 0 }

        it { is_expected.to be_falsey }
      end
    end
  end
end
