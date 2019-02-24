class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :items, :string
    add_column :users, :introduce, :text
    add_column :users, :public, :boolean, default: false, null: false
    add_column :users, :deleted, :boolean, default: false, null: false
  end
end
