class RemoveKindFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :kind, :string
  end
end
