class RenameCategoryForQas < ActiveRecord::Migration[5.1]
  def change
    rename_column :qas, :type, :category
  end
end
