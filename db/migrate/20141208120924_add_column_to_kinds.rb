class AddColumnToKinds < ActiveRecord::Migration
  def change
    add_column :kinds, :user_id, :integer
  end
end
