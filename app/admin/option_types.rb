ActiveAdmin.register OptionType do
  permit_params :name, :description, option_values_attributes: %i[id name description base_price availability_type stock _destroy]

  filter :name
  filter :description
  filter :option_values_name, as: :string

  index do
    selectable_column
    id_column
    column :name
    column :description
    column 'Option Values' do |option_type|
      option_type.option_values.map(&:name).to_sentence
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

    panel 'Option Values' do
      table_for option_type.option_values do
        column('Name') { |ov| ov.name }
        column('Description') { |ov| ov.description }
        column('Base price') { |ov| number_to_currency(ov.base_price, unit: '€') }
        column 'Availability' do |ov|
          [
            ov.availability_type.humanize,
            (ov.stock if ov.stock_controlled?)
          ].compact.join(': ')
        end
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs 'Option Type Details' do
      f.input :name
      f.input :description
    end

    f.has_many :option_values, allow_destroy: true, new_record: true, heading: 'Option Values' do |ov|
      ov.input :name
      ov.input :description
      ov.input :base_price
      ov.input :availability_type
      ov.input :availability_type, as: :select, collection: OptionValue.availability_types.keys.map { |k| [k.humanize, k] }, prompt: 'Select Availability Type'
      ov.input :stock
    end

    f.actions
  end
end
