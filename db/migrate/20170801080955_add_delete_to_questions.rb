class AddDeleteToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :deleted_at, :datetime
    add_index :questions, :deleted_at
  end
end
