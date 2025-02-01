class CreateProductOptionValues < ActiveRecord::Migration[8.0]
  def change
    create_table :product_option_values do |t|
      t.references :product_option_type, null: false, foreign_key: true
      t.references :option_value, null: false, foreign_key: true

      t.timestamps
    end

    add_index :product_option_values, [:product_option_type_id, :option_value_id], unique: true
  end
end
