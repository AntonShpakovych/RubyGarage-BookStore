# frozen_string_literal: true

ActiveAdmin.register Book do
  decorate_with BookDecorator

  permit_params :name, :description, :quantity, :year_of_publication, :price,
                :height, :width, :length, :materials, :category_id,
                author_ids: []

  index do
    selectable_column
    id_column

    column :category
    column :name
    column :full_description, :short_description
    column :price
    column :authors, :all_authors
    actions
  end

  show do
    attributes_table do
      row :category
      row :name
      row :authors, :all_authors
      row :description, :full_description
      row :year_of_publication
      row :height
      row :width
      row :length
      row :materials
      row :price
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :category
      f.input :name
      f.input :authors, collection: Author.all, as: :check_boxes
      f.input :description
      f.input :year_of_publication
      f.input :height
      f.input :width
      f.input :length
      f.input :materials
      f.input :price
      f.input :quantity
    end
    actions
  end
end
