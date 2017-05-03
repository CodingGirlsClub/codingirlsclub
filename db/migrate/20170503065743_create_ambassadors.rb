class CreateAmbassadors < ActiveRecord::Migration[5.1]
  def change
    create_table :ambassadors do |t|
      t.integer :user_id
      t.string  :self_introduction
      t.boolean :applied, default: false
      t.string  :resume_url

      t.timestamps null: false
    end
  end
end
