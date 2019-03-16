class RenameContentColumnToMemo < ActiveRecord::Migration[5.2]
  def change
    rename_column :do_mokus, :content, :memo
  end
end
