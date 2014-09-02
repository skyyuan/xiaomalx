class CreateElectiveRegistrations < ActiveRecord::Migration
  def change
    create_table :elective_registrations do |t|
      t.integer :student_id
      t.integer :elective_id
      t.timestamps
    end
  end
end
