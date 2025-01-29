class OptionValue < ApplicationRecord
  db_belongs_to :option_type
  has_many :product_option_values, dependent: :restrict_with_error
  has_many :products, through: :product_option_values

  validates :name, presence: true

  # Ransack configuration:
  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description]
  end
end
