class CreateLatentUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :latent_users do |t|
      t.integer :user_id
      t.string  :email,  limit: 80
      t.boolean :active, default: false

      t.timestamps null: false
    end

    add_index :latent_users, :user_id
    add_index :latent_users, :email
  end
end
