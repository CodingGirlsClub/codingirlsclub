class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.integer :qa_id
      t.string  :title

      t.timestamps null: false
    end
  end
end
