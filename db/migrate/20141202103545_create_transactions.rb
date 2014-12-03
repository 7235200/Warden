class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :name
      t.decimal :price
      t.string :kind
      t.references :user, index: true
      t.references :kind, index: true

      t.timestamps
    end
    add_index :transactions, [:user_id, :created_at]
  end
end
