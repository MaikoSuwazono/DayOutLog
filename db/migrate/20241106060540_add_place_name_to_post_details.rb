class AddPlaceNameToPostDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :post_details, :place_name, :string
  end
end
