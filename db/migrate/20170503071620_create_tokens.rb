class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string  :name,    limit: 40
      t.boolean :general, default: false

      t.timestamps null: false
    end
  end
end
