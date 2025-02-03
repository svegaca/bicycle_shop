class OptionValue < ApplicationRecord
  db_belongs_to :option_type
  has_many :product_option_values, dependent: :restrict_with_error

  enum :availability_type, %i[always_in_stock out_of_stock stock_controlled].index_with(&:to_s), validate: true

  validates :name, presence: true
  validates :base_price, numericality: {greater_than_or_equal_to: 0}
  validates :stock, numericality: {only_integer: true}, if: :stock_controlled?

  def available?
    return true if always_in_stock?
    return false if out_of_stock?

    stock.positive?
  end

  # Ransack configuration:
  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description]
  end
end
