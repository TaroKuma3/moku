class ChangeDatatypeMemoPublicOfWorks < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :memo_public, :integer
    add_column :works, :memo_public, :boolean, default: false, null: false
  end
end
