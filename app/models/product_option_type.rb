class ProductOptionType < ApplicationRecord
  db_belongs_to :product
  db_belongs_to :option_type

  validates_db_uniqueness_of :option_type_id, scope: :product_id
end
