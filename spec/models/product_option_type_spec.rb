require 'rails_helper'

RSpec.describe ProductOptionType, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:option_type) }
  end

  describe 'validations' do
    it { is_expected.to validate_db_uniqueness_of(:option_type_id).scoped_to(:product_id) }
  end
end
