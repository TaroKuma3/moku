class RenameCommentColumnToMemo < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :comment, :memo
  end
end
