class CreateUserReferrals < ActiveRecord::Migration[5.1]
  def change
    create_table :user_referrals do |t|
      t.string  :code, limit: 20
      t.integer :inviter_id
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :user_referrals, :inviter_id
    add_index :user_referrals, :user_id
  end
end
