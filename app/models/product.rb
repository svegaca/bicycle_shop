class Product < ApplicationRecord
  has_many :product_option_types, dependent: :destroy
  has_many :option_types, through: :product_option_types
  has_many :option_values, through: :product_option_types
  has_many :combination_rules, dependent: :destroy

  accepts_nested_attributes_for :product_option_types, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :combination_rules, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true

  # Ransack configuration:
  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description]
  end
end
