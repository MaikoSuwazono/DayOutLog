class RemoveColumnFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :address
    remove_column :posts, :latitude
    remove_column :posts, :longitude

    add_column :post_details, :address, :string
    add_column :post_details, :latitude, :float
    add_column :post_details, :longitude, :float
  end
end
