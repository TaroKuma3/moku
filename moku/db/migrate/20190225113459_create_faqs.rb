class CreateFaqs < ActiveRecord::Migration[5.2]
  def change
    create_table :faqs do |t|
      t.integer :user_id
      t.string "questions"
      t.string "answer"

      t.timestamps
    end
  end
end
