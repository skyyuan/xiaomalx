class AddPhotoConsultantUsers < ActiveRecord::Migration
  def change
    add_column :consultant_users, :photo, :string
  end
end
