class ProductOptionValue < ApplicationRecord
  db_belongs_to :product_option_type
  db_belongs_to :option_value

  enum :availability_type, %i[always_in_stock out_of_stock stock_controlled].index_with(&:to_s), validate: true

  validates_db_uniqueness_of :option_value_id, scope: :product_option_type_id
  validates :stock, numericality: {only_integer: true}, if: :stock_controlled?

  def available?
    return true if always_in_stock?
    return false if out_of_stock?

    stock.positive?
  end

  def availability_details
    [
      availability_type.humanize,
      (stock if stock_controlled?)
    ].compact.join(': ')
  end
end
