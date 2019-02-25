class CreateDoMokus < ActiveRecord::Migration[5.2]
  def change
    create_table :do_mokus do |t|
      t.integer :user_id
      t.integer "moku_type_id"
      t.datetime "started_at"
      t.datetime "finished_at"
      t.integer "moku_time"
      t.string "content"
      t.boolean "mjn_public", default: true, null: false
      t.boolean "deleted", default: false, null: false

      t.timestamps
    end
  end
end
