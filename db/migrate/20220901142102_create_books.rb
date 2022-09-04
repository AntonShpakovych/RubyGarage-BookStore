class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.text :description, null: false
      t.decimal :height, precision: 4, scale: 2, null: false
      t.decimal :width, precision: 4, scale: 2, null: false
      t.decimal :length, precision: 4, scale: 2, null: false
      t.integer :quantity, null: false
      t.integer :year_of_publication, null: false
      t.string :materials, null: false
      t.belongs_to :category, index: true, foreign_key: true, null: false
      t.timestamps
    end
  end
end
