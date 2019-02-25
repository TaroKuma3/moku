class CreateMokuTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :moku_types do |t|
      t.integer :user_id
      t.string "name"
      t.boolean "deleted", default: false, null: false

      t.timestamps
    end
  end
end
