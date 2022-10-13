class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.belongs_to :order, foreign_key: true, null: false
      t.belongs_to :book, foreign_key: true, null: false
      t.integer :quantity, null: false
      t.timestamps
    end
  end
end
