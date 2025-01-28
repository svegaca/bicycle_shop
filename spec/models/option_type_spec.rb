require 'rails_helper'

RSpec.describe OptionType, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:option_values).dependent(:destroy) }
    it { is_expected.to have_many(:product_option_types).dependent(:destroy) }
    it { is_expected.to have_many(:products).through(:product_option_types) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
