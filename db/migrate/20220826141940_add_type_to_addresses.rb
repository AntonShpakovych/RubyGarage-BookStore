class AddTypeToAddresses < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :type, :string
  end
end
