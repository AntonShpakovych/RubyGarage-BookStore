class AddWidthToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :width, :float
  end
end
