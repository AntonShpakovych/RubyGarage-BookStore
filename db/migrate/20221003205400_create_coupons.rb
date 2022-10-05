class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :code, null: false
      t.float :discount, null: false
      t.belongs_to :order, foreign_key: true, index: false
      t.timestamps
    end
    add_index :coupons, [:order_id], unique: true
  end
end
