class AddKindToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :kind_name, :string
  end
end
