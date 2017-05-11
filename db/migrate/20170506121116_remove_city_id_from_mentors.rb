class RemoveCityIdFromMentors < ActiveRecord::Migration[5.1]
  def change
    remove_column :mentors, :city_id
  end
end
