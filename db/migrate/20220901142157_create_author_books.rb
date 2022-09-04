class CreateAuthorBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :author_books do |t|
      t.belongs_to :book, foreign_key: true, null: false, unique: true
      t.belongs_to :author, foreign_key:  true, null: false, unique: true
      t.timestamps
    end
  end
end
