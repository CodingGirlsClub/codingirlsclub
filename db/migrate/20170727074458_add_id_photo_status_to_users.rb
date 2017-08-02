class AddIdPhotoStatusToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :id_photo_status, :string, limit: 50
  end
end
