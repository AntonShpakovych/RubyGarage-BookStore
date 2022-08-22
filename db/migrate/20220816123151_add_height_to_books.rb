class AddHeightToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :height, :float
  end
end
