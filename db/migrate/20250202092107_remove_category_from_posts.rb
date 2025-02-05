class RemoveCategoryFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :category, :string
    remove_column :posts, :string, :string
  end
end
