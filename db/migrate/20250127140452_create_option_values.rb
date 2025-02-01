class CreateOptionValues < ActiveRecord::Migration[8.0]
  def change
    create_table :option_values do |t|
      t.references :option_type, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.decimal :base_price, null: false
      t.string :availability_type, null: false
      t.integer :stock

      t.timestamps
    end
  end
end
