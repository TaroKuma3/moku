class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.integer :user_id
      t.integer "moku_id"
      t.string "title"
      t.text "comment"
      t.integer "comment_public"
      t.boolean "pickup_public", default: false, null: false
      t.boolean "deleted", default: false, null: false

      t.timestamps
    end
  end
end
