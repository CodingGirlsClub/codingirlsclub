class CreateMentors < ActiveRecord::Migration[5.1]
  def change
    create_table :mentors do |t|
      t.integer :user_id
      t.text    :introduce_self
      t.text    :why_to_teach
      t.string  :master_lang
      t.integer :city_id
      t.string  :teaching_time
      t.string  :phone_number
      t.string  :wechat_id
      t.string  :github_url
      t.string  :ever_project_url
      t.string  :resume_url
      t.boolean :applied, default: false

      t.timestamps null: false
    end
  end
end
