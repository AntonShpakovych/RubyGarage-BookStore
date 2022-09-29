class AddImagesToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :images, :json
  end
end
