class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string  :country,  limit: 40
      t.string  :province, limit: 40
      t.string  :name,     limit: 40
      t.string  :district, limit: 40
      t.string  :zipcode,  limit: 40
      t.integer :parent_id
      t.integer :level

      t.timestamps null: false
    end
  end
end
