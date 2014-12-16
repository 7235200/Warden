class CreatePurposes < ActiveRecord::Migration
  def change
    create_table :purposes do |t|
      t.string :name
      t.string :description
      t.decimal :money
      t.decimal :storage
      t.integer :user_id
      t.references :user, index: true
      t.timestamps
    end
  end
end
