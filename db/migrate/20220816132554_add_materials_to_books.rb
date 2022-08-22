class AddMaterialsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :materials, :string
  end
end
