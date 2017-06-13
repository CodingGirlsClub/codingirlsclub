class CreateCoursesMentors < ActiveRecord::Migration[5.1]
  def change
    create_table :courses_mentors do |t|
      t.integer :course_id
      t.integer :mentor_id
    end

    add_index :courses_mentors, :course_id
    add_index :courses_mentors, :mentor_id
  end
end
