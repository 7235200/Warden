class AddColumnToKinds < ActiveRecord::Migration
  def change
    add_column :kinds, :user\q_id, :integer
  end
end
