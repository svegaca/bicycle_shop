class ProductOptionType < ApplicationRecord
  db_belongs_to :product
  db_belongs_to :option_type
  has_many :product_option_values, dependent: :destroy
  has_many :option_values, through: :product_option_values

  accepts_nested_attributes_for :product_option_values, allow_destroy: true, reject_if: :all_blank

  validates_db_uniqueness_of :option_type_id, scope: :product_id
end
