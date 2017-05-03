class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.string   :name,                    limit: 80
      t.string   :email,                   limit: 80
      t.string   :password_digest
      t.string   :mobile,                  limit: 20

      t.integer  :casting,                 limit: 4, default: 0
      t.integer  :gender,                  limit: 4, default: 0
      t.text     :introduction
      t.string   :avatar_url
      t.integer  :city_id

      t.datetime :last_login
      t.string   :last_ip

      t.timestamps null: false
    end
  end
end
