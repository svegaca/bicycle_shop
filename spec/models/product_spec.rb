require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:product_option_types).dependent(:destroy) }
    it { is_expected.to have_many(:option_types).through(:product_option_types) }
    it { is_expected.to have_many(:option_values).through(:product_option_types) }
    it { is_expected.to have_many(:combination_rules).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
