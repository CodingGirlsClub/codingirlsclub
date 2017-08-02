class AddCityIdToMentors < ActiveRecord::Migration[5.1]
  def change
    add_column :mentors, :city_id, :integer
  end
end
