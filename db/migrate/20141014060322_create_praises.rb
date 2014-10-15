class CreatePraises < ActiveRecord::Migration
  def change
    create_table :praises do |t|
      t.integer :answer_id
      t.integer :user_id
      t.integer :consultant
      t.timestamps
    end
  end
end
