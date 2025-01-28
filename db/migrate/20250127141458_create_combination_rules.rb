class CreateCombinationRules < ActiveRecord::Migration[8.0]
  def change
    create_table :combination_rules do |t|
      t.references :product, null: false, foreign_key: true
      t.string :type, null: false
      t.text :description
      t.decimal :modifier_amount

      t.timestamps
    end
  end
end
