class RenameContentPublicColumnToMemoPublic < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :comment_public, :memo_public
  end
end
