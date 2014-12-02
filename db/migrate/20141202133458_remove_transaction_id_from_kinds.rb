class RemoveTransactionIdFromKinds < ActiveRecord::Migration
  def change
    remove_column :kinds, :transaction_id, :integer
  end
end
