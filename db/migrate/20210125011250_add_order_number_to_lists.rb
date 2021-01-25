class AddOrderNumberToLists < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :order_number, :integer
  end
end
