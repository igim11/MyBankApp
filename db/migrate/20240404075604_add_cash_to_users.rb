class AddCashToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :cash, :decimal, precision: 10, scale: 2, default: 0.00
  end
end
