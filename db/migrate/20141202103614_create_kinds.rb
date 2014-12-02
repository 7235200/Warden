class CreateKinds < ActiveRecord::Migration
  def change
    create_table :kinds do |t|
      t.string :name
      t.references :transaction, index: true

      t.timestamps
    end
    add_index :kinds, [:transaction_id, :created_at]
  end
end
