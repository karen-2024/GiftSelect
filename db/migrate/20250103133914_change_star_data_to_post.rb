class ChangeStarDataToPost < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :star, :float
  end
end
