class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :type
      t.decimal :amount, precision: 10, scale: 2
      t.integer :to_account
      t.integer :from_account

      t.timestamps
    end
  end
end
