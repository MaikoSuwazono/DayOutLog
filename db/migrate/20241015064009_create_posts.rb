class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title, :null => false
      t.date :departure_date, :null => false

      t.timestamps
    end
  end
end
