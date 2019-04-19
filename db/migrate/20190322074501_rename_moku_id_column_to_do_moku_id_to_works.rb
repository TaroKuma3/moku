class RenameMokuIdColumnToDoMokuIdToWorks < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :moku_id, :do_moku_id
  end
end
