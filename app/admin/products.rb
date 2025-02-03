ActiveAdmin.register Product do
  permit_params :name, :description,
                product_option_types_attributes: [
                  :id, :option_type_id, :_destroy,
                  product_option_values_attributes: [
                    :id, :option_value_id, :_destroy
                  ]
                ],
                combination_rules_attributes: [
                  :id, :type, :description, :modifier_amount, :_destroy,
                  combination_rule_values_attributes: [
                    :id, :option_value_id, :_destroy
                  ]
                ]

  filter :name
  filter :description

  index do
    selectable_column
    id_column
    column :name
    column :description
    column 'Option Types' do |product|
      product.option_types.map(&:name).to_sentence
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :created_at
      row :updated_at
    end

    panel 'Product Option Types' do
      table_for product.product_option_types do
        column 'Option Type' do |pot|
          pot.option_type.name
        end
        column 'Option Values' do |pot|
          pot.product_option_values.map { |pov| pov.option_value.name }.to_sentence
        end
      end
    end

    panel 'Combination Rules' do
      table_for product.combination_rules do
        column 'Type' do |rule|
          rule.type.underscore.humanize
        end
        column 'Description' do |rule|
          rule.description
        end
        column 'Details' do |rule|
          if rule.is_a?(PriceModifierCombinationRule)
            "Modifier amount: #{number_to_currency(rule.modifier_amount, unit: '€')}"
          end
        end
        column 'Combination criteria' do |rule|
          rule.option_values.map(&:name).to_sentence
        end
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs 'Product Details' do
      f.input :name
      f.input :description
    end

    f.has_many :product_option_types, allow_destroy: true, new_record: true, heading: 'Option Types' do |pot_form|
      pot_form.input :option_type, as: :select, collection: OptionType.all.pluck(:name, :id), prompt: 'Select Option Type'

      pot_form.has_many :product_option_values, allow_destroy: true, new_record: true, heading: 'Option Values' do |pov_form|
        pov_form.input :option_value, as: :select, collection: OptionValue.all.pluck(:name, :id), prompt: 'Select Option Value'
      end
    end

    f.has_many :combination_rules, allow_destroy: true, new_record: true, heading: 'Combination Rules' do |rule_form|
      rule_form.input :type, as: :select, collection: ['ForbiddenCombinationRule', 'PriceModifierCombinationRule'], prompt: 'Select Rule Type', input_html: {disabled: rule_form.object.persisted?}
      rule_form.input :description
      rule_form.input :modifier_amount

      rule_form.has_many :combination_rule_values, allow_destroy: true, new_record: true, heading: 'Option Values' do |crv_form|
        crv_form.input :option_value, as: :select, collection: product.option_values.pluck(:name, :id), prompt: 'Select Option Value'
      end
    end

    f.actions
  end
end
