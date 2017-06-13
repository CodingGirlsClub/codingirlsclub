class CreateReferrals < ActiveRecord::Migration[5.1]
  def change
    create_table :referrals do |t|
      t.string   :code, limit: 20
      t.integer  :user_id
      t.integer  :category, default: 0
      t.datetime :expired_at

      t.timestamps null: false
    end

    add_index :referrals, :code
  end
end
