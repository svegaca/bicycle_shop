class CreateCombinationRuleValues < ActiveRecord::Migration[8.0]
  def change
    create_table :combination_rule_values do |t|
      t.references :combination_rule, null: false, foreign_key: true
      t.references :option_value, null: false, foreign_key: true

      t.timestamps
    end

    add_index :combination_rule_values, [:combination_rule_id, :option_value_id], unique: true
  end
end
