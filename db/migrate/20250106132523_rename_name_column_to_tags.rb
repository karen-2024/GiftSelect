class RenameNameColumnToTags < ActiveRecord::Migration[6.1]
  def change
    rename_column :tags, :name, :tagname
  end
end
