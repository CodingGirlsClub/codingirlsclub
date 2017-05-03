class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string   :name,           limit: 80
      t.string   :full_name,      limit: 80
      t.string   :email,          limit: 80
      t.string   :password_digest
      t.string   :mobile,         limit: 20
      t.integer  :gender,         limit: 4, default: 0
      t.string   :age_range,      limit: 20
      t.text     :introduction
      t.string   :avatar
      t.string   :id_photo
      t.string   :github_url
      t.string   :wechat_id,      limit: 80
      t.integer  :city_id
      t.integer  :university_id
      t.datetime :last_login
      t.string   :last_ip
      t.text     :description

      t.timestamps null: false
    end

    add_index :users, :email,  unique: true
    add_index :users, :mobile, unique: true
    add_index :users, :name
  end
end
