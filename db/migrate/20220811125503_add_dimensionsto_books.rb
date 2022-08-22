class AddDimensionstoBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :dimensions, :string
  end
end
