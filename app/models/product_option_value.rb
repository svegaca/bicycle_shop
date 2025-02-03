class ProductOptionValue < ApplicationRecord
  db_belongs_to :product_option_type
  db_belongs_to :option_value

  validates_db_uniqueness_of :option_value_id, scope: :product_option_type_id
end
