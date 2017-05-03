class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string  :token,       limit: 150
      t.string  :secret,      limit: 150
      t.string  :provider,    limit: 40
      t.string  :sid,         limit: 40
      t.string  :uniq_id
      t.string  :email,       limit: 150
      t.string  :name,        limit: 150
      t.string  :location,    limit: 150
      t.string  :photo,       limit: 150
      t.string  :url,         limit: 150
      t.text    :description

      t.timestamps null: false
    end

		add_index :accounts, [:provider, :sid], name: 'index_accounts_on_provider_and_sid', unique: true
  end
end
