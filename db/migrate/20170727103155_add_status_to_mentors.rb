class AddStatusToMentors < ActiveRecord::Migration[5.1]
  def change
    add_column :mentors, :status, :string, limit: 50

    remove_column :mentors, :applied
  end
end
