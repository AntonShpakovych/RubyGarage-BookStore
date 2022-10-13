class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.string :number, null: false
      t.string :date, null: false
      t.string :cvv, null: false
      t.string :name, null: false
      t.belongs_to :order, foreign_key: true, index: { unique: true }
      t.timestamps
    end
  end
end
