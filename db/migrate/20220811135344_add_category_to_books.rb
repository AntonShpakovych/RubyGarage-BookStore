class AddCategoryToBooks < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :books, :category
  end
end
