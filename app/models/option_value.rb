class OptionValue < ApplicationRecord
  db_belongs_to :option_type
  has_many :product_option_values, dependent: :destroy
  has_many :products, through: :product_option_values

  validates :name, presence: true
end
