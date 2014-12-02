class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :name
      t.decimal :price
      t.string :type

      t.timestamps
    end
  end
end
