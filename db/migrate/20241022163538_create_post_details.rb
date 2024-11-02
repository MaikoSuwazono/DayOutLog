class CreatePostDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :post_details do |t|
      t.references :post, null: false
      t.string :body, null: false
      t.datetime :arrival_at, null: false
      t.string :image

      t.timestamps
    end
  end
end
