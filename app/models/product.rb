class Product < ApplicationRecord
  has_many :product_option_types, dependent: :destroy
  has_many :option_types, through: :product_option_types
  has_many :product_option_values, dependent: :destroy
  has_many :option_values, through: :product_option_values
  has_many :combination_rules, dependent: :destroy

  validates :name, presence: true
  validates :base_price, numericality: {greater_than_or_equal_to: 0}
end
