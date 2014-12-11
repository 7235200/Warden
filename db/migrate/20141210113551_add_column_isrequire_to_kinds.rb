class AddColumnIsrequireToKinds < ActiveRecord::Migration
  def change
    add_column :kinds, :isRequire, :boolean
  end
end
