class KindsIdFixToKindId < ActiveRecord::Migration
  def change
    rename_column :transactions, :kinds_id, :kind_id
  end
end
