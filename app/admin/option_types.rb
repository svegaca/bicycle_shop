ActiveAdmin.register OptionType do
  permit_params :name, :description, option_values_attributes: [:id, :name, :description, :_destroy]

  filter :name
  filter :description
  filter :option_values_name, as: :string#, label: 'Nombre de Option Value'

  # Index Page
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

  # Show Page
  show do
    attributes_table do
      row :id
      row :name
      row :description
      row 'Option Values' do |option_type|
        ul do
          option_type.option_values.each do |option_value|
            li option_value.name
          end
        end
      end
      row :created_at
      row :updated_at
    end
  end

  # Form Page
  form do |f|
    f.semantic_errors

    f.inputs 'Option Type Details' do
      f.input :name
      f.input :description
    end

    f.has_many :option_values, allow_destroy: true, new_record: true, heading: 'Option Values' do |ov|
      ov.input :name
      ov.input :description
    end

    f.actions
  end
end
