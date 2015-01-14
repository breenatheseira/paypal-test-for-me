class AddTotalAmountCentsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total_amount_cents, :integer
  end
end
