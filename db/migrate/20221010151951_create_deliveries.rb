class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.string :name, null: false
      t.integer :from_date, null: false
      t.integer :to_date, null: false
      t.float :price, null: false
      t.timestamps
    end
  end
end
