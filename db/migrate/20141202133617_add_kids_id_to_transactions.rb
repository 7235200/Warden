class AddKidsIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :kind_id, :integer
    add_index :transactions, :kind_id
  end
end
