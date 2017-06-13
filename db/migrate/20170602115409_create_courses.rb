class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer :topic_id
      t.string  :name, limit: 50
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: false
    end

    add_index :courses, :topic_id
  end
end
