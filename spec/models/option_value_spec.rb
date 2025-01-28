require 'rails_helper'

RSpec.describe OptionValue, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:option_type) }
    it { is_expected.to have_many(:product_option_values).dependent(:destroy) }
    it { is_expected.to have_many(:products).through(:product_option_values) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
