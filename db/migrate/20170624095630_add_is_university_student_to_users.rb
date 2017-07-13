class AddIsUniversityStudentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_university_student, :boolean, default: true
  end
end
