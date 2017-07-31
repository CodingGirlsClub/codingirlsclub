class AddStatusToAmbassadors < ActiveRecord::Migration[5.1]
  def change
    add_column :ambassadors, :status, :string, limit: 50
    add_column :ambassadors, :city_id, :integer
    add_column :ambassadors, :university_id, :integer
    remove_column :ambassadors, :applied
  end
end
