class CreateUniversities < ActiveRecord::Migration[5.1]
  def change
    create_table :universities do |t|
      t.integer :city_id
      t.string  :name,     limit: 50
      t.text    :description

      t.timestamps null: false
    end
  end
end
