class AddLengthoBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :length, :float
  end
end
