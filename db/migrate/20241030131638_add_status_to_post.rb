class AddStatusToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :status, :integer, default: 0

    change_column_null :posts, :status, false
  end
end
