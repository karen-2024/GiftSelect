class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.string :name
      t.text :introduction
      t.integer :amount
      t.string :package
      t.integer :price
      t.integer :prefecture
      t.string :location
      t.integer :recommend
      t.string :title
      t.text :review
      t.integer :user_id

      t.timestamps
    end
  end
end
