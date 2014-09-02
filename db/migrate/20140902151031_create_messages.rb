class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :student_id
      t.integer :state
      t.integer :curriculum_id
      t.integer :is_check, default: 0
      t.timestamps
    end
  end
end
