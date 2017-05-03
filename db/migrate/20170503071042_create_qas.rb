class CreateQas < ActiveRecord::Migration[5.1]
  def change
    create_table :qas do |t|
      t.string  :title
      t.text    :description
      t.string  :type
      t.boolean :applied, default: false

      t.timestamps null: false
    end
  end
end
