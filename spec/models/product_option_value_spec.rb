require 'rails_helper'

RSpec.describe ProductOptionValue, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:option_value) }
  end

  describe 'validations' do
    it { is_expected.to validate_inclusion_of(:availability_type).in_array(described_class.availability_types.keys) }
    it { is_expected.to validate_db_uniqueness_of(:option_value_id).scoped_to(:product_id) }

    describe 'stock' do
      it { is_expected.not_to validate_numericality_of(:stock).only_integer }

      context 'when availability depends on the stock' do
        before { subject.availability_type = :stock_controlled }

        it { is_expected.to validate_numericality_of(:stock).only_integer }
      end
    end
  end

  describe '#available?' do
    subject(:available) { product_option_value.available? }

    let(:product_option_value) { build_stubbed(:product_option_value, availability) }

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
        before { product_option_value.stock = 5 }

        it { is_expected.to be_truthy }
      end

      context 'without stock' do
        before { product_option_value.stock = 0 }

        it { is_expected.to be_falsey }
      end
    end
  end
end
