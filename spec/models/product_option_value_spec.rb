require 'rails_helper'

RSpec.describe ProductOptionValue, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:product_option_type) }
    it { is_expected.to belong_to(:option_value) }
  end

  describe 'validations' do
    it { is_expected.to validate_db_uniqueness_of(:option_value_id).scoped_to(:product_option_type_id) }
  end
end
