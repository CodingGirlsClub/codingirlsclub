class AddStatusToQas < ActiveRecord::Migration[5.1]
  def change
    add_column :qas, :status, :string, limit: 50
    add_index :qas, :status

    remove_column :qas, :applied
  end
end
