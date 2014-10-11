class AddPhotoElders < ActiveRecord::Migration
  def change
    add_column :elders, :photo, :string
  end
end
