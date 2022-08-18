class RemoveDimensionsFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :dimensions
  end
end
