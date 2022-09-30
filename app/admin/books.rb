# frozen_string_literal: true

ActiveAdmin.register Book do
  includes :category
  decorate_with BookDecorator

  permit_params :name, :description, :quantity, :year_of_publication, :price,
                :height, :width, :length, :materials, :category_id, :main_image,
                author_ids: [], images: []

  index do
    selectable_column
    id_column

    column :category
    column :name
    column :full_description, :short_description
    column :price
    column :authors, :all_authors
    column :main_image do |book|
      image_tag(book.main_image.url, class: 'admin-book_logo')
    end
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
      book.images.each do |image|
        row image do
          image_tag(image.url, class: 'admin-book_show')
        end
      end
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
      f.input :price, :min => Book::MIN_PRICE_VALUE
      f.input :quantity
      f.input :main_image, as: :file
      f.input :images, as: :file, input_html: { multiple: true }
    end
    actions
  end
end
