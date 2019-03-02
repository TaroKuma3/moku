class DeleteMjnPublicFormDoMokus < ActiveRecord::Migration[5.2]
  def change
    remove_column :do_mokus, :mjn_public, :boolean
  end
end
