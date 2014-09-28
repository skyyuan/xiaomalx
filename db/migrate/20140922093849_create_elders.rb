class CreateElders < ActiveRecord::Migration
  def change
    create_table :elders do |t|
      t.string :nickname
      t.string :password
      t.string :phone
      t.string :open_id
      t.timestamps
    end
  end
end
