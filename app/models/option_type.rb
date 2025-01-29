class OptionType < ApplicationRecord
  has_many :option_values, dependent: :destroy
  has_many :product_option_types, dependent: :restrict_with_error
  has_many :products, through: :product_option_types

  accepts_nested_attributes_for :option_values, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true

  # Ransack configuration:
  def self.ransackable_associations(auth_object = nil)
    ['option_values']
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description]
  end
end
