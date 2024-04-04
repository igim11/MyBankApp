class RenameTypeColumnInTransactionsToAction < ActiveRecord::Migration[7.1]
  def change
    rename_column :transactions, :type, :action
  end
end
